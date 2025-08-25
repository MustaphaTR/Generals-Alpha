#region Copyright & License Information
/*
 * Copyright (c) The OpenRA Developers and Contributors
 * This file is part of OpenRA, which is free software. It is made
 * available to you under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version. For more
 * information, see COPYING.
 */
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using OpenRA.Mods.Common;
using OpenRA.Mods.Common.Traits;
using OpenRA.Primitives;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	[Desc("This trait provide a similar driver & hijacker system like that in TS/General.",
		"Disable this trait will set to no pilot. Pause this trait will not eject pilot when actor killed.")]
	public class PilotChamberInfo : PausableConditionalTraitInfo, Requires<CapturableInfo>
	{
		[ActorReference]
		[Desc("Default pilot of this vehicle.")]
		public readonly string DefaultPilotActor = null;

		[Desc("Name of the unit can be pilot, whom will override the pilot in this actor.",
			"This actor type needs to have the Parachutable trait defined.",
			"Boolean defines if pilot needs level to eject. ")]
		public readonly Dictionary<string, bool> PilotActorTypesOverrideWhenCapture = [];

		[Desc("Actor types that gives experience to this actor when capture.")]
		public readonly HashSet<string> GiveExperiencePilotActorTypes = [];

		[Desc("Probability that the aircraft's pilot gets ejected once the aircraft is destroyed.")]
		public readonly int EjectSuccessRate = 100;

		[Desc("Sound to play when ejecting the pilot from the aircraft.")]
		public readonly string ChuteSound = null;

		[Desc("Can a destroyed aircraft eject its pilot while it has not yet fallen to ground level?")]
		public readonly bool EjectInAir = false;

		[Desc("Can a destroyed aircraft eject its pilot when it falls to ground level?")]
		public readonly bool EjectOnGround = false;

		[Desc("Risks stuck units when they don't have the Paratrooper trait.")]
		public readonly bool AllowUnsuitableCell = false;

		[Desc("Map player to use on ejection when pilot owner is defeated.")]
		public readonly string FallBackOwner = "Neutral";

		public override object Create(ActorInitializer init) { return new PilotChamber(this); }
	}

	public class PilotChamber : PausableConditionalTrait<PilotChamberInfo>, INotifyCreated, INotifyKilled, INotifyCapture
	{
		GainsExperience selfExp;
		string currentPilot;
		int currentPilotLevel;
		Player currentPilotOwner;

		public PilotChamber(PilotChamberInfo info)
			: base(info) {	}

		protected override void Created(Actor self)
		{
			selfExp = self.TraitsImplementing<GainsExperience>().Where(t => t.IsTraitEnabled()).FirstOrDefault();
			currentPilot = Info.DefaultPilotActor;
			currentPilotOwner = self.Owner;
			currentPilotLevel = 0;
			base.Created(self);
		}

		void INotifyCapture.OnCapture(Actor self, Actor captor, Player oldOwner, Player newOwner, BitSet<CaptureType> captureTypes)
		{
			currentPilotOwner = captor.Owner;

			var exp = captor.TraitsImplementing<GainsExperience>().Where(t => t.IsTraitEnabled()).FirstOrDefault();
			if (Info.PilotActorTypesOverrideWhenCapture.ContainsKey(captor.Info.Name))
			{
				currentPilot = captor.Info.Name;

				if (exp != null)
					currentPilotLevel = exp.Level;
				else
					currentPilotLevel = 0;
			}
			else
			{
				currentPilot = Info.DefaultPilotActor;
				currentPilotLevel = 0;
			}

			// Because revoking experience is not implemented,
			// we only make captured vechcle has the max level bettween itself and pilot.
			if (Info.GiveExperiencePilotActorTypes.Contains(captor.Info.Name) && selfExp != null && exp != null && exp.Level > selfExp.Level)
				selfExp.GiveLevels(exp.Level - selfExp.Level);
		}

		protected override void TraitDisabled(Actor self)
		{
			currentPilot = null;
			currentPilotOwner = null;
			currentPilotLevel = 0;
			base.TraitDisabled(self);
		}

		void INotifyKilled.Killed(Actor self, AttackInfo e)
		{
			if (IsTraitDisabled || IsTraitPaused || self.Owner.WinState == WinState.Lost || !self.World.Map.Contains(self.Location) || currentPilot == null)
				return;

			var pilotLevel = Math.Max(currentPilotLevel, selfExp != null ? selfExp.Level : 0);
			if (Info.PilotActorTypesOverrideWhenCapture[currentPilot] && pilotLevel <= 0)
				return;

			if (self.World.SharedRandom.Next(100) >= Info.EjectSuccessRate)
				return;

			var cp = self.CenterPosition;
			var inAir = !self.IsAtGroundLevel();
			if ((inAir && !Info.EjectInAir) || (!inAir && !Info.EjectOnGround))
				return;

			var pilotOwner = (currentPilotOwner != null && currentPilotOwner.WinState != WinState.Lost) ? currentPilotOwner : self.World.Players.First(p => p.InternalName == Info.FallBackOwner);

			self.World.AddFrameEndTask(w =>
			{
				// `currentPilot` can be null before FrameEndTask running
				// we need to cache and check it
				var pilot = currentPilot;
				if (pilot == null)
					return;
				else
					pilot = pilot.ToLowerInvariant();

				if (!Info.AllowUnsuitableCell)
				{
					var pilotInfo = self.World.Map.Rules.Actors[pilot];
					var pilotPositionable = pilotInfo.TraitInfo<IPositionableInfo>();
					if (!pilotPositionable.CanEnterCell(self.World, null, self.Location))
						return;
				}

				var td = new TypeDictionary
				{
					new OwnerInit(pilotOwner),
					new LocationInit(self.Location)
				};

				// If airborne, offset the spawn location so the pilot doesn't drop on another infantry's head
				var spawnPos = cp;
				if (inAir)
				{
					var subCell = self.World.ActorMap.FreeSubCell(self.Location);
					if (subCell != SubCell.Invalid)
					{
						td.Add(new SubCellInit(subCell));
						spawnPos = self.World.Map.CenterOfSubCell(self.Location, subCell) + new WVec(0, 0, spawnPos.Z);
					}
				}

				td.Add(new CenterPositionInit(spawnPos));

				var pilotActor = self.World.CreateActor(true, pilot, td);
				if (pilotActor == null)
					return;

				// Give experience to pilot
				if (pilotLevel > 0)
					pilotActor.TraitsImplementing<GainsExperience>().Where(t => t.IsTraitEnabled()).FirstOrDefault()?.GiveLevels(pilotLevel);

				if (!inAir)
					pilotActor.QueueActivity(false, new Nudge(pilotActor));
				else
					Game.Sound.Play(SoundType.World, Info.ChuteSound, cp);
			});
		}
	}
}
