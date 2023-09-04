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
using OpenRA.Mods.Common.Effects;
using OpenRA.Mods.Common.Traits;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	public class SupplyCenterInfo : TraitInfo, Requires<BuildingInfo>
	{
		public readonly HashSet<string> SupplyTypes = new() { "supply" };

		[Desc("Store resources in silos. Adds cash directly without storing if set to false.")]
		public readonly bool UseStorage = true;

		[Desc("Discard resources once silo capacity has been reached.")]
		public readonly bool DiscardExcessResources = false;

		[FieldLoader.Require]
		[Desc("Where can the supply collectors can place the supplies.")]
		public readonly CVec[] DeliveryOffsets = Array.Empty<CVec>();

		[Desc("Trade supplies to only one collector in dock at a time.")]
		public readonly bool DeliverOneByOne = true;

		[Desc("When a collector is comming and working for delivering (HACK: not waiting), occupancy will be inceased by collector.",
			"Note: only when both `ToleratedOccupancy` and `ToleratedStuckRoad` are reached,",
			"this dock will prevent non-aircraft auto-select this dock, and suggest aircraft not to auto-select this dock")]
		public readonly int ToleratedOccupancy = 6;

		[Desc("When a collector is within `StuckRoadCheckRange`, road stucking will be inceased by collector")]
		public readonly int ToleratedStuckRoad = 9;

		[Desc("Road stucking checking range, and force make way range when entry is stuck.")]
		public readonly WDist StuckRoadCheckRange = WDist.FromCells(3);

		[Desc("Force all collectors with `StuckRoadCheckRange` to make way after this delay, if a collector stuck on `DeliveryOffsets`.")]
		public readonly int ForceMakeWayDelay = 18;

		public readonly bool ShowTicks = true;
		public readonly int TickLifetime = 30;
		public readonly int TickVelocity = 2;
		public readonly int TickRate = 10;

		public override object Create(ActorInitializer init) { return new SupplyCenter(init.Self, this); }
	}

	public sealed class SupplyCenter : ITick, IResourceExchange, INotifyCreated, INotifyOwnerChanged
	{
		const int CheckDelivererOnDockTick = 61;
		int checkTick;

		public readonly SupplyCenterInfo Info;
		PlayerResources playerResources;
		IResourceValueModifier[] resourceMultipliers;

		public readonly Dictionary<CPos, HashSet<CPos>> NoParkingOffsets = new();

		int currentDisplayTick = 0;
		int currentDisplayValue = 0;
		Actor collectorInTrade;

		public SupplyCenter(Actor self, SupplyCenterInfo info)
		{
			Info = info;
			playerResources = self.Owner.PlayerActor.Trait<PlayerResources>();
			currentDisplayTick = info.TickRate;
		}

		void INotifyCreated.Created(Actor self)
		{
			resourceMultipliers = self.TraitsImplementing<IResourceValueModifier>().ToArray();
			checkTick = self.World.SharedRandom.Next(0, CheckDelivererOnDockTick);

			var bi = self.Info.TraitInfoOrDefault<BuildingInfo>();
			if (bi == null)
				return;

			foreach (var offset in Info.DeliveryOffsets)
			{
				var entrys = new List<CPos>();
				foreach (var direction in CVec.Directions)
				{
					entrys.AddRange(new List<CVec>() { offset }.Select(c => c + direction).SkipWhile(
						e => Info.DeliveryOffsets.Contains(e) ||
						(bi.Footprint.TryGetValue(e, out var r) && r is not FootprintCellType.OccupiedPassable or FootprintCellType.Empty)).
						Select(c => c + self.Location));
				}

				NoParkingOffsets.Add(offset + self.Location, entrys.ToHashSet());
			}
		}

		public bool CanGiveResource(int amount) { return !Info.UseStorage || Info.DiscardExcessResources || playerResources.CanGiveResources(amount); }

		public void GiveResource(int amount, string collector)
		{
			amount = Util.ApplyPercentageModifiers(amount, resourceMultipliers.Select(m => m.GetResourceValueModifier()));

			if (Info.UseStorage)
			{
				if (Info.DiscardExcessResources)
					amount = Math.Min(amount, playerResources.ResourceCapacity - playerResources.Resources);

				playerResources.GiveResources(amount);
			}
			else
				playerResources.GiveCash(amount);

			if (Info.ShowTicks)
				currentDisplayValue += amount;
		}

		public bool RegisterTrade(Actor self, Actor collector)
		{
			if (!Info.DeliverOneByOne || collector == collectorInTrade)
				return true;

			if (collectorInTrade == null || collectorInTrade.IsDead || !collectorInTrade.IsInWorld)
			{
				collectorInTrade = collector;
				return true;
			}

			return false;
		}

		public bool AtDeliveryZone(Actor self, CPos location)
		{
			if (NoParkingOffsets.ContainsKey(location))
				return true;

			return false;
		}

		public bool AtNoParkingZone(Actor self, CPos location)
		{
			if (NoParkingOffsets.ContainsKey(location) || NoParkingOffsets.Values.Any(e => e.Contains(location)))
				return true;

			return false;
		}

		public void UnregisterTrade(Actor self, Actor collector)
		{
			if (!Info.DeliverOneByOne)
				return;

			if (collector == collectorInTrade)
				collectorInTrade = null;
		}

		public void ShouldChangeCenter(Actor self, Actor collector)
		{
			var collectorTrait = collector.TraitOrDefault<SupplyCollector>();
			if (collectorTrait == null)
				return;

			var stuckroad = 0;
			var occupancy = 0;
			foreach (var c in self.World.ActorsWithTrait<SupplyCollector>())
			{
				if (CanStuckRoad(self, c.Actor))
					stuckroad += collectorTrait.IsAircraft ? c.Trait.Info.StuckRoadPowerAir : c.Trait.Info.StuckRoadPower;

				if (c.Trait.DeliveryBuilding == self && SupplyCollector.IsCollectorBusyOnDelivering(c))
					occupancy += c.Trait.Info.OccupancyPower;
			}

			if (stuckroad > Info.ToleratedStuckRoad && occupancy > Info.ToleratedOccupancy)
				collectorTrait.FindOtherDeliveryBuildingAdvisor = self;
		}

		public bool CanStuckRoad(Actor self, Actor collector)
		{
			if ((self.CenterPosition - collector.CenterPosition).HorizontalLengthSquared <= Info.StuckRoadCheckRange.LengthSquared)
				return true;
			return false;
		}

		public void HandlingStuck(Actor self, Actor stuckCollector)
		{
			foreach (var c in self.World.ActorsWithTrait<SupplyCollector>().Where(c =>
			c.Trait.Info.DeliveryRelationships.HasRelationship(c.Actor.Owner.RelationshipWith(self.Owner)) &&
			c.Trait.WorkingAtPortState == WorkingAtPortState.None &&
			(self.CenterPosition - c.Actor.CenterPosition).HorizontalLengthSquared <= Info.StuckRoadCheckRange.LengthSquared))
			{
				c.Trait.MakeWay();
			}
		}

		void ITick.Tick(Actor self)
		{
			if (Info.ShowTicks && currentDisplayValue > 0 && --currentDisplayTick <= 0)
			{
				var temp = currentDisplayValue;
				if (self.Owner.IsAlliedWith(self.World.RenderPlayer))
					self.World.AddFrameEndTask(w => w.Add(new FloatingText(self.CenterPosition, self.Owner.Color, FloatingText.FormatCashTick(temp), 30)));
				currentDisplayTick = Info.TickRate;
				currentDisplayValue = 0;
			}

			// Check if any collector blocked here but has goods to delivery
			if (--checkTick <= 0)
			{
				checkTick = CheckDelivererOnDockTick;
				foreach (var loc in NoParkingOffsets.Keys)
				{
					var collectors = self.World.ActorMap.GetActorsAt(loc).ToList();
					foreach (var c in collectors)
					{
						var colletorTrait = (c == null || c.IsDead || !c.IsInWorld) ? null : c.TraitOrDefault<SupplyCollector>();
						if (colletorTrait != null && !colletorTrait.IsEmpty &&
							colletorTrait.WorkingAtPortState == WorkingAtPortState.None &&
							colletorTrait.Info.DeliveryRelationships.HasRelationship(c.Owner.RelationshipWith(self.Owner)))
						{
							c.CancelActivity();
							colletorTrait.DeliveryBuilding = self;
							colletorTrait.TakeTheChanceToDeliver();
						}
					}
				}
			}
		}

		void INotifyOwnerChanged.OnOwnerChanged(Actor self, Player oldOwner, Player newOwner)
		{
			playerResources = newOwner.PlayerActor.Trait<PlayerResources>();
		}
	}
}
