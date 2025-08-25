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
using System.Linq;
using OpenRA.Mods.Common.Traits;
using OpenRA.Traits;

namespace OpenRA.Mods.Yupgi_alert.Traits
{
	[Desc("Spawn new actors when sold.")]
	public class EmitInfantryOnDeathInfo : TraitInfo
	{
		public readonly int ValuePercent = 40;

		[ActorReference]
		[Desc("Be sure to use lowercase. Default value is \"e1\".")]
		public readonly string[] ActorTypes = ["e1"];

		[Desc("Spawns actors only if the owner player's faction is in this list. " +
			"Leave empty to allow all factions by default.")]
		public readonly HashSet<string> Factions = [];

		[Desc("Should an actor spawn after the player has been defeated (e.g. after surrendering)?")]
		public readonly bool SpawnAfterDefeat = false;

		public override object Create(ActorInitializer init) { return new EmitInfantryOnDeath(init.Self, this); }
	}

	public class EmitInfantryOnDeath : INotifyKilled
	{
		readonly EmitInfantryOnDeathInfo info;
		readonly bool correctFaction;

		public EmitInfantryOnDeath(Actor self, EmitInfantryOnDeathInfo info)
		{
			this.info = info;
			var factionsList = info.Factions;
			correctFaction = factionsList.Count == 0 || factionsList.Contains(self.Owner.Faction.InternalName);
		}

		void Emit(Actor self)
		{
			var defeated = self.Owner.WinState == WinState.Lost;
			if (defeated && !info.SpawnAfterDefeat)
				return;

			if (!correctFaction)
				return;

			var csv = self.Info.TraitInfoOrDefault<CustomSellValueInfo>();
			var valued = self.Info.TraitInfoOrDefault<ValuedInfo>();
			var cost = csv != null ? csv.Value : (valued != null ? valued.Cost : 0);

			var dudesValue = info.ValuePercent * cost / 100;

			var buildingInfo = self.Info.TraitInfoOrDefault<BuildingInfo>();

			var eligibleLocations = buildingInfo != null ? buildingInfo.Tiles(self.Location).ToList() : [];
			var actorTypes = info.ActorTypes.Select(a => new { Name = a, Cost = self.World.Map.Rules.Actors[a].TraitInfo<ValuedInfo>().Cost }).ToList();

			while (eligibleLocations.Count > 0 && actorTypes.Any(a => a.Cost <= dudesValue))
			{
				var at = actorTypes.Where(a => a.Cost <= dudesValue).Random(self.World.SharedRandom);
				var loc = eligibleLocations.Random(self.World.SharedRandom);

				eligibleLocations.Remove(loc);
				dudesValue -= at.Cost;

				self.World.AddFrameEndTask(w => w.CreateActor(at.Name,
				[
					new LocationInit(loc),
					new OwnerInit(self.Owner),
				]));
			}
		}

		void INotifyKilled.Killed(Actor self, AttackInfo e) { Emit(self); }
	}
}
