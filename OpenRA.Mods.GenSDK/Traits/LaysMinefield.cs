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
using OpenRA.Mods.Common.Traits;
using OpenRA.Primitives;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	[Desc("This actor places mines around itself, and replenishes them after a while.")]
	public class LaysMinefieldInfo : PausableConditionalTraitInfo
	{
		[FieldLoader.Require]
		[Desc("Types of mines to place, if multipile is defined, a random one will be selected.")]
		public readonly HashSet<string> Mines = new();

		[FieldLoader.Require]
		[Desc("Locations to place the mines, from top-left of the building.")]
		public readonly CVec[] Locations = Array.Empty<CVec>();

		[Desc("Initial delay to create the mines.")]
		public readonly int InitialDelay = 1;

		[Desc("Recreate the mines, if they are destroyed after this much of time. Use -1 to disable respawn.")]
		public readonly int RecreationInterval = 2500;

		[Desc("Remove the mines if the trait gets disabled.")]
		public readonly bool RemoveOnDisable = true;

		public override object Create(ActorInitializer init) { return new LaysMinefield(this); }
	}

	public class LaysMinefield : PausableConditionalTrait<LaysMinefieldInfo>, INotifyKilled, INotifyOwnerChanged, INotifyActorDisposing, ITick, ISync
	{
		[Sync]
		int ticks;

		bool spawned;
		readonly List<Actor> mines = new List<Actor>();

		public LaysMinefield(LaysMinefieldInfo info)
			: base(info)
		{
			ticks = Info.InitialDelay;
		}

		void ITick.Tick(Actor self)
		{
			if (IsTraitPaused || IsTraitDisabled)
				return;

			if (spawned && Info.RecreationInterval < 0)
				return;

			if (--ticks < 0)
			{
				spawned = true;
				ticks = Info.RecreationInterval;
				SpawnMines(self);
			}
		}

		public void SpawnMines(Actor self)
		{
			foreach (var offset in Info.Locations)
			{
				var cell = self.Location + offset;
				var actor = Info.Mines.Random(self.World.SharedRandom).ToLowerInvariant();
				var ai = self.World.Map.Rules.Actors[actor];
				var ip = ai.TraitInfoOrDefault<IPositionableInfo>();

				if (ip != null && !ip.CanEnterCell(self.World, null, cell))
					continue;

				self.World.AddFrameEndTask(w =>
				{
					var mine = w.CreateActor(actor.ToLowerInvariant(), new TypeDictionary
					{
						new OwnerInit(self.Owner),
						new LocationInit(cell)
					});

					mines.Add(mine);
				});
			}
		}

		public void RemoveMines()
		{
			foreach (var mine in mines)
				mine.Dispose();

			mines.Clear();
		}

		void INotifyOwnerChanged.OnOwnerChanged(Actor self, Player oldOwner, Player newOwner)
		{
			foreach (var mine in mines)
				mine.ChangeOwnerSync(newOwner);
		}

		protected override void TraitDisabled(Actor self)
		{
			ticks = Info.InitialDelay;

			if (Info.RemoveOnDisable)
				RemoveMines();
		}

		void INotifyKilled.Killed(Actor self, AttackInfo e)
		{
			RemoveMines();
		}

		void INotifyActorDisposing.Disposing(Actor self)
		{
			RemoveMines();
		}
	}
}
