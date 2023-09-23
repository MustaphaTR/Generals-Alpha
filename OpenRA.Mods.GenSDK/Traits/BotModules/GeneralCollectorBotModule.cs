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
using OpenRA.Mods.Common.Activities;
using OpenRA.Mods.Common.Traits;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	[TraitLocation(SystemActors.Player)]
	[Desc("Put this on the Player actor. Manages bot collector to ensure they always continue collecting as long as there are resources on the map.")]
	public class GeneralCollectorBotModuleInfo : ConditionalTraitInfo
	{
		[Desc("Actor types that are considered collectors. Leave empty to include all actor with " + nameof(SupplyCollector))]
		public readonly HashSet<string> CollectorTypes = null;

		[Desc("Actor types that are supplies. Leave empty to include all actor with " + nameof(SupplyDock))]
		public readonly HashSet<string> SupplyType = null;

		[Desc("Interval (in ticks) between giving out orders to idle harvesters.")]
		public readonly int AssignRoleInterval = 601;

		public override object Create(ActorInitializer init) { return new GeneralCollectorBotModule(init.Self, this); }
	}

	public class GeneralCollectorBotModule : ConditionalTrait<GeneralCollectorBotModuleInfo>, IBotTick
	{
		readonly World world;
		readonly Player player;
		readonly Func<Actor, bool> unitCannotBeOrdered;
		readonly GeneralCollectorBotModuleInfo info;

		int scanForIdleCollectorsTicks;
		bool initialized;
		TraitPair<SupplyDock>[] supplies;

		public GeneralCollectorBotModule(Actor self, GeneralCollectorBotModuleInfo info)
			: base(info)
		{
			this.info = info;
			world = self.World;
			player = self.Owner;
			unitCannotBeOrdered = a => a.Owner != self.Owner || a.IsDead || !a.IsInWorld;
		}

		protected override void TraitEnabled(Actor self)
		{
			// Avoid all AIs scanning for idle harvesters on the same tick, randomize their initial scan delay.
			scanForIdleCollectorsTicks = world.LocalRandom.Next(0, Info.AssignRoleInterval);
		}

		void IBotTick.BotTick(IBot bot)
		{
			if (!initialized)
			{
				supplies = bot.Player.World.ActorsWithTrait<SupplyDock>().Where(at => info.SupplyType == null || info.SupplyType.Contains(at.Actor.Info.Name)).OrderByDescending(at => (at.Actor.Location - player.HomeLocation).LengthSquared).ToArray();
				initialized = true;
			}

			if (--scanForIdleCollectorsTicks > 0)
				return;

			scanForIdleCollectorsTicks = Info.AssignRoleInterval;

			var collectors = world.ActorsWithTrait<SupplyCollector>().Where(at => !unitCannotBeOrdered(at.Actor) && (info.CollectorTypes == null || info.CollectorTypes.Contains(at.Actor.Info.Name)));

			// Find idle harvesters and give them orders:
			foreach (var c in collectors)
			{
				if (!c.Actor.IsIdle && !(c.Actor.CurrentActivity is FlyIdle))
				{
					if (c.Actor.CurrentActivity is not FindAndDeliverResources act || !act.LastSearchFailed)
						continue;
				}

				// Tell the idle harvester to quit slacking:
				var newSafeSupply = FindNextSupply(c);
				if (newSafeSupply.Type != TargetType.Invalid)
				{
					AIUtils.BotDebug($"AI: Collector {c.Actor} is idle. Ordering to {newSafeSupply} collect.");
					bot.QueueOrder(new Order("Collect", c.Actor, newSafeSupply, false));
				}
				else
				{
					// If no resource, tell harvester to stop scanning by itself
					AIUtils.BotDebug($"AI: no valid supply for Collector {c.Actor}.");
					bot.QueueOrder(new Order("Stop", c.Actor, false));
				}

				break;
			}
		}

		Target FindNextSupply(TraitPair<SupplyCollector> collector)
		{
			var target = Target.Invalid;

			foreach (var supply in supplies.OrderBy(at => (at.Actor.Location - collector.Actor.Location).LengthSquared))
			{
				if (supply.Actor.IsDead || !supply.Actor.IsInWorld || !collector.Trait.IsAcceptableTradeBuilding(supply.Actor, supply.Trait))
					continue;

				if (!AIUtils.PathExist(collector.Actor, supply.Actor.Location, supply.Actor))
					continue;

				target = Target.FromActor(supply.Actor);
				break;
			}

			return target;
		}
	}
}
