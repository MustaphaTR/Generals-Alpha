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

using System.Collections.Generic;
using OpenRA.Mods.Common.Traits;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	[Desc("This actor places mines around itself, and replenishes them after a while.")]
	public class LaysMinefieldInfo : PausableConditionalTraitInfo
	{
		[ActorReference]
		[FieldLoader.Require]
		[Desc("Types of mines to place, if multipile is defined, a random one will be selected.")]
		public readonly HashSet<string> Mines = [];

		[FieldLoader.Require]
		[Desc("Locations to place the mines, from top-left of the building.")]
		public readonly CVec[] Locations = [];

		[Desc("Initial delay to create the mines.")]
		public readonly int InitialDelay = 0;

		[Desc("Recreate the mines, if they are destroyed after this much of time.")]
		public readonly int RecreationInterval = 500;

		[Desc("Remove the mines if the trait gets disabled.")]
		public readonly bool RemoveOnDisable = true;

		public override object Create(ActorInitializer init) { return new LaysMinefield(this); }
	}

	public class LaysMinefield : PausableConditionalTrait<LaysMinefieldInfo>, INotifyKilled, INotifyOwnerChanged, INotifyActorDisposing, ITick
	{
		readonly List<Actor> mines = [];
		readonly List<int> ticks = [];

		public LaysMinefield(LaysMinefieldInfo info)
			: base(info)
		{
			for (var i = 0; i < Info.Locations.Length; i++)
			{
				mines.Add(null);
				ticks.Add(Info.InitialDelay);
			}
		}

		void ITick.Tick(Actor self)
		{
			if (IsTraitPaused || IsTraitDisabled)
				return;

			for (var i = 0; i < mines.Count; i++)
			{
				if (mines[i] != null && !mines[i].IsDead)
					continue;

				if (--ticks[i] < 0)
					SpawnMine(self, i);
			}
		}

		public void SpawnMine(Actor self, int index)
		{
			var cell = self.Location + Info.Locations[index];
			var actor = Info.Mines.Random(self.World.SharedRandom).ToLowerInvariant();
			var ai = self.World.Map.Rules.Actors[actor];
			var ip = ai.TraitInfoOrDefault<IPositionableInfo>();

			ticks[index] = Info.RecreationInterval;
			if (ip != null && !ip.CanEnterCell(self.World, null, cell))
				return;

			self.World.AddFrameEndTask(w =>
			{
				var mine = w.CreateActor(actor.ToLowerInvariant(),
				[
					new OwnerInit(self.Owner),
					new LocationInit(cell)
				]);

				mines[index] = mine;
			});
		}

		public void RemoveMines()
		{
			for (var i = 0; i < mines.Count; i++)
			{
				mines[i]?.Dispose();
				mines[i] = null;
			}
		}

		void INotifyOwnerChanged.OnOwnerChanged(Actor self, Player oldOwner, Player newOwner)
		{
			foreach (var mine in mines)
				mine?.ChangeOwnerSync(newOwner);
		}

		protected override void TraitDisabled(Actor self)
		{
			for (var i = 0; i < mines.Count; i++)
				ticks[i] = Info.InitialDelay;

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
