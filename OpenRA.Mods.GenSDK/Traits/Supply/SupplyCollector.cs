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
using OpenRA.Mods.Common.Activities;
using OpenRA.Mods.Common.Traits;
using OpenRA.Mods.GenSDK.Activities;
using OpenRA.Mods.GenSDK.Orders;
using OpenRA.Primitives;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	public enum FacingWhenDock { Any, TowardsTarget, Specific }
	public enum WorkingAtPortState { None = 0, Registering = 1, Working = 2, Done = 3 }

	public class SupplyCollectorInfo : TraitInfo
	{
		public readonly HashSet<string> SupplyTypes = new() { "supply" };

		public readonly bool AutomaticDeliverOnOnwerActor = true;
		public readonly PlayerRelationship DeliveryRelationships = PlayerRelationship.Ally;
		public readonly PlayerRelationship CollectionRelationships = PlayerRelationship.Ally | PlayerRelationship.Neutral;

		[Desc("How long (in ticks) to wait until (re-)checking for a nearby available TradeActors if not yet linked to one.")]
		public readonly int SearchForCollectionBuildingDelay = 125;

		[Desc("How long (in ticks) to wait until (re-)checking for a nearby available DeliveryBuilding if not yet linked to one.")]
		public readonly int SearchForDeliveryBuildingDelay = 125;

		[Desc("How long (in ticks) does it take to collect supplies.")]
		public readonly int CollectionDelay = 25;

		[Desc("How long (in ticks) does it take to deliver supplies.")]
		public readonly int DeliveryDelay = 25;

		[Desc("How long (in ticks) to wait when DockSupply/DockCenter is trading.")]
		public readonly int WaitForTradeDuration = 5;

		[Desc("How long (in ticks) to wait if DockSupply/DockCenter is stucking.")]
		public readonly int WaitInlineDuration = 30;

		[Desc("Automatically scan for trade building when created.")]
		public readonly bool SearchOnCreation = true;

		[Desc("How much cash can this actor can carry.")]
		public readonly int Capacity = 300;

		[Desc("This unit has this power on stuck the docking area of supply center. For example:",
			"Infantry can set to 1, because it occupied less cell and easy to get through",
			"Vehicle can set to 5, because it occupied 1 cell and harder to get through")]
		public readonly int OccupancyPower = 3;

		[Desc("This unit has this power on stuck the road when waiting, for actor with mobile. For example:",
			"Infantry can set to 1, because it occupied less cell and easy to get through",
			"Vehicle can set to 5, because it occupied 1 cell and harder to get through")]
		public readonly int StuckRoadPower = 3;

		[Desc("This unit has this power on stuck the road when waiting, for actor with aircarft.")]
		public readonly int StuckRoadPowerAir = 1;

		[Desc("Conditions to grant when collector has more than specified amount of supplies.",
			"A dictionary of [integer]: [condition].")]
		public readonly Dictionary<int, string> FullnessConditions = new();

		[Desc("Collector faces mechanic before taking the supplies.")]
		public readonly FacingWhenDock FacingWhenDockAtSupplyPile = FacingWhenDock.Any;

		[Desc("Collector faces this way before taking the supplies. Effective when `FacingWhenDockAtSupplyPile` is `Specific`.")]
		public readonly WAngle SpecificFacingOnSupply = default;

		[Desc("Collector faces mechanic before trading with center.")]
		public readonly FacingWhenDock FacingWhenDockAtSupplyCenter = FacingWhenDock.Any;

		[Desc("Collector faces this way before trading with center. Effective when `FacingWhenDockAtSupplyCenter` is `Specific`.")]
		public readonly WAngle SpecificFacingOnCenter = default;

		[GrantedConditionReference]
		public IEnumerable<string> LinterFullnessConditions { get { return FullnessConditions.Values; } }

		[VoiceReference]
		public readonly string CollectVoice = null;

		[VoiceReference]
		public readonly string DeliverVoice = null;

		public override object Create(ActorInitializer init) { return new SupplyCollector(init.Self, this); }
	}

	public sealed class SupplyCollector : IIssueOrder, IResolveOrder, IOrderVoice, ISync, INotifyCreated, INotifyBlockingMove, ISupplyCollector
	{
		public readonly SupplyCollectorInfo Info;
		readonly Mobile mobile;
		readonly Actor self;

		readonly Dictionary<int, int> fullnessTokens = new();

		public int Amount;
		int ISupplyCollector.Amount() { return Amount; }

		public WorkingAtPortState WorkingAtPortState = WorkingAtPortState.None;
		public IResourceValueModifier[] ResourceMultipliers;

		[Sync]
		public Actor DeliveryBuilding = null;

		[Sync]
		public Actor CollectionBuilding = null;

		public Actor FindOtherCollectionBuildingAdvisor = null;
		public Actor FindOtherDeliveryBuildingAdvisor = null;

		public readonly bool IsAircraft;

		public SupplyCollector(Actor self, SupplyCollectorInfo info)
		{
			this.self = self;
			Info = info;
			mobile = self.TraitOrDefault<Mobile>();
			IsAircraft = self.Info.HasTraitInfo<AircraftInfo>();
			Amount = 0;
		}

		void INotifyCreated.Created(Actor self)
		{
			ResourceMultipliers = self.TraitsImplementing<IResourceValueModifier>().ToArray();

			// Avoid stuck on production
			DeliveryBuilding = self.World.ActorsHavingTrait<SupplyCenter>().ClosestTo(self);

			if (Info.SearchOnCreation)
				self.World.AddFrameEndTask(w => self.QueueActivity(new FindGoods(self, Color.Green)));

			CheckConditions(self);
		}

		void INotifyBlockingMove.OnNotifyBlockingMove(Actor self, Actor blocking)
		{
			if (!blocking.Owner.IsAlliedWith(self.Owner) || WorkingAtPortState > WorkingAtPortState.None || (self.CurrentActivity is not FindGoods && self.CurrentActivity is not DeliverGoods))
				return;

			var collector = blocking.TraitOrDefault<SupplyCollector>();
			if (collector == null)
				return;

			var center = collector.DeliveryBuilding;
			var centerTrait = center != null && !center.IsDead && center.IsInWorld ? center.TraitOrDefault<SupplyCenter>() : null;
			if (centerTrait != null)
			{
				if (!IsEmpty && centerTrait.AtDeliveryZone(center, self.Location))
				{
					self.CancelActivity();
					TakeTheChanceToDeliver();
				}

				var noParking = centerTrait?.Info.DeliveryOffsets.Select(c => center.Location + c).ToList();
				if (noParking.Contains(blocking.Location))
				{
					MakeWay();
					return;
				}
			}

			var dock = collector.CollectionBuilding;
			var dockTrait = dock != null && !dock.IsDead && dock.IsInWorld ? dock.TraitOrDefault<SupplyDock>() : null;
			if (dockTrait != null)
			{
				var noParking = dockTrait?.Info.CollectionOffsets.Select(c => dock.Location + c).ToList();
				if (noParking.Contains(blocking.Location))
				{
					MakeWay();
					return;
				}
			}
		}

		public void TakeTheChanceToDeliver()
		{
			self.QueueActivity(new DeliverGoods(self, Color.Green));
			self.ShowTargetLines();
		}

		public void MakeWay()
		{
			self.CancelActivity();
			self.QueueActivity(new Nudge(self));
			self.QueueActivity(new Nudge(self));
			if (IsEmpty)
			{
				self.QueueActivity(new FindGoods(self, Color.Green));
			}
			else
			{
				self.QueueActivity(new DeliverGoods(self, Color.Green));
			}

			self.ShowTargetLines();
		}

		public bool IsFull { get { return Amount == Info.Capacity; } }
		public bool IsEmpty { get { return Amount == 0; } }
		public int Fullness { get { return Amount * 100 / Info.Capacity; } }

		public IEnumerable<IOrderTargeter> Orders
		{
			get
			{
				yield return new GenericTargeter<BuildingInfo>("Collect", 5,
					a => IsEmpty && a.TraitOrDefault<SupplyDock>() != null && Info.SupplyTypes.Overlaps(a.Trait<SupplyDock>().Info.SupplyTypes) && !a.Trait<SupplyDock>().IsEmpty && Info.CollectionRelationships.HasRelationship(self.Owner.RelationshipWith(a.Owner)),
					a => "enter");
				yield return new GenericTargeter<BuildingInfo>("Deliver", 5,
					a => !IsEmpty && a.TraitOrDefault<SupplyCenter>() != null && Info.SupplyTypes.Overlaps(a.Trait<SupplyCenter>().Info.SupplyTypes) && Info.DeliveryRelationships.HasRelationship(self.Owner.RelationshipWith(a.Owner)),
					a => "enter");
			}
		}

		public Order IssueOrder(Actor self, IOrderTargeter order, in Target target, bool queued)
		{
			if (order.OrderID == "Collect")
				return new Order(order.OrderID, self, target, queued);

			if (order.OrderID == "Deliver")
				return new Order(order.OrderID, self, target, queued);

			return null;
		}

		string IOrderVoice.VoicePhraseForOrder(Actor self, Order order)
		{
			if (Info.CollectVoice != null && order.OrderString == "Collect")
				return Info.CollectVoice;

			if (Info.DeliverVoice != null && order.OrderString == "Deliver" && !IsEmpty)
				return Info.DeliverVoice;

			return null;
		}

		public void ResolveOrder(Actor self, Order order)
		{
			// TODO: Add support for FrozenActors
			if (order.Target.Type != TargetType.Actor)
				return;

			var targetActor = order.Target.Actor;
			if (order.OrderString == "Collect")
			{
				var dock = targetActor.TraitOrDefault<SupplyDock>();
				if (dock == null || !Info.SupplyTypes.Overlaps(dock.Info.SupplyTypes))
					return;

				if (IsFull)
					return;

				if (targetActor != CollectionBuilding)
					CollectionBuilding = targetActor;

				WorkingAtPortState = WorkingAtPortState.None;

				var next = new FindGoods(self, Color.Green);
				self.QueueActivity(order.Queued, next);
				self.ShowTargetLines();
			}
			else if (order.OrderString == "Deliver")
			{
				var center = targetActor.TraitOrDefault<SupplyCenter>();
				if (center == null || !Info.SupplyTypes.Overlaps(center.Info.SupplyTypes))
					return;

				if (IsEmpty)
					return;

				if (targetActor != DeliveryBuilding)
					DeliveryBuilding = targetActor;

				WorkingAtPortState = WorkingAtPortState.None;

				var next = new DeliverGoods(self, Color.Green);
				self.QueueActivity(order.Queued, next);
				self.ShowTargetLines();
			}
		}

		public void CheckConditions(Actor self)
		{
			foreach (var pair in Info.FullnessConditions)
			{
				if (Amount >= pair.Key && !fullnessTokens.ContainsKey(pair.Key))
					fullnessTokens.Add(pair.Key, self.GrantCondition(pair.Value));

				if (Amount < pair.Key && fullnessTokens.TryGetValue(pair.Key, out var fullnessToken))
				{
					self.RevokeCondition(fullnessToken);
					fullnessTokens.Remove(pair.Key);
				}
			}
		}

		public static bool IsCollectorBusyOnCollecting(TraitPair<SupplyCollector> c)
		{
			return c.Actor.CurrentActivity is FindGoods &&
				((c.Actor.CurrentActivity.ChildActivity is not Wait) ||
				(c.Actor.CurrentActivity.ChildActivity is not Nudge) ||
				c.Trait.WorkingAtPortState > WorkingAtPortState.None);
		}

		public static bool IsCollectorBusyOnDelivering(TraitPair<SupplyCollector> c)
		{
			return c.Actor.CurrentActivity is DeliverGoods &&
				((c.Actor.CurrentActivity.ChildActivity is not Wait) ||
				(c.Actor.CurrentActivity.ChildActivity is not Nudge) ||
				c.Trait.WorkingAtPortState > WorkingAtPortState.None);
		}

		bool IsAcceptableTradeBuilding(Actor supplyDock, SupplyDock dock)
		{
			return Info.SupplyTypes.Overlaps(dock.Info.SupplyTypes) && !dock.IsEmpty &&
				Info.CollectionRelationships.HasRelationship(self.Owner.RelationshipWith(supplyDock.Owner));
		}

		/* Conclusion: We skip a building that is "stucky around and fully occupied", reseaon below:
		 * 1. `Stuck` may caused by other supply center/dock. --> We need to check to make sure it is not our choice.
		 * 2. `Occupancy` cannot deal the case of remote mining.--> We need check stucky for that.
		 *
		 * And notice that Occupancy should only generate by the actors that is active to related Activity (Move, dealing with supply).
		 * Otherwise, case of "a group of collector can forever `Wait` near the building, meanwhile make the building be skipped forever from all other collectors".
		 * will happen.
		 */
		public Actor ClosestTradeBuilding(Actor self, Actor ignore)
		{
			var docks = self.World.ActorsWithTrait<SupplyDock>()
				.Where(d => !d.Actor.IsDead && d.Actor.IsInWorld && d.Actor != ignore &&
				IsAcceptableTradeBuilding(d.Actor, d.Trait));

			var collectors = self.World.ActorsWithTrait<SupplyCollector>().ToArray();
			if (IsAircraft)
			{
				Actor bestdock = null;
				foreach (var dock in docks.OrderByDescending(d => (d.Actor.Location - self.Location).LengthSquared))
				{
					var stuckroad = 0;
					var occupancy = 0;
					foreach (var c in collectors)
					{
						if (dock.Trait.CanStuckRoad(dock.Actor, c.Actor))
							stuckroad += c.Trait.Info.StuckRoadPowerAir;

						if (c.Trait.CollectionBuilding == dock.Actor && IsCollectorBusyOnCollecting(c))
							occupancy += c.Trait.Info.OccupancyPower;
					}

					if (stuckroad < dock.Trait.Info.ToleratedStuckRoad ||
						occupancy < dock.Trait.Info.ToleratedOccupancy || bestdock == null)
						bestdock = dock.Actor;
				}

				return bestdock;
			}

			if (mobile != null)
			{
				// Find all supply centers and their occupancy count:
				// Note: for non-aircraft, we exclude supply centers with too many collectors clogging the collect location.
				var accessibleDocks = new Dictionary<CPos, (Actor Actor, int Occupancy)>();
				foreach (var dock in docks)
				{
					var stuckroad = 0;
					var occupancy = 0;
					foreach (var c in collectors)
					{
						if (dock.Trait.CanStuckRoad(dock.Actor, c.Actor))
							stuckroad += c.Trait.Info.StuckRoadPower;

						if (c.Trait.CollectionBuilding == dock.Actor && IsCollectorBusyOnCollecting(c))
							occupancy += c.Trait.Info.OccupancyPower;
					}

					if (stuckroad < dock.Trait.Info.ToleratedStuckRoad || occupancy < dock.Trait.Info.ToleratedOccupancy)
						accessibleDocks[dock.Actor.World.Map.CellContaining(dock.Actor.CenterPosition)] = (dock.Actor, stuckroad);
				}

				// Start a search from each supply center's collect location:
				var path = mobile.PathFinder.FindPathToTargetCells(
					self, self.Location, accessibleDocks.Select(r => r.Key), BlockedByActor.None,
					location => accessibleDocks.TryGetValue(location, out var r) ? r.Occupancy : 0);

				if (path.Count > 0)
					return accessibleDocks[path[0]].Actor;

				return null;
			}

			return null;
		}

		bool IsAcceptableDeliveryBuilding(Actor supplyCenter, bool isAutomatic = false)
		{
			return Info.SupplyTypes.Overlaps(supplyCenter.Trait<SupplyCenter>().Info.SupplyTypes) &&
				isAutomatic && Info.AutomaticDeliverOnOnwerActor ? self.Owner == supplyCenter.Owner :
				Info.DeliveryRelationships.HasRelationship(self.Owner.RelationshipWith(supplyCenter.Owner));
		}

		public Actor ClosestDeliveryBuilding(Actor self, Actor ignore)
		{
			var centers = self.World.ActorsWithTrait<SupplyCenter>()
				.Where(c => !c.Actor.IsDead && c.Actor.IsInWorld && c.Actor != ignore &&
				IsAcceptableDeliveryBuilding(c.Actor, true));
			var collectors = self.World.ActorsWithTrait<SupplyCollector>().ToArray();

			if (IsAircraft)
			{
				Actor bestcenter = null;
				foreach (var center in centers.OrderByDescending(c => (c.Actor.Location - self.Location).LengthSquared))
				{
					var stuckroad = 0;
					var occupancy = 0;
					foreach (var c in collectors)
					{
						if (center.Trait.CanStuckRoad(center.Actor, c.Actor))
							stuckroad += c.Trait.Info.StuckRoadPowerAir;

						if (c.Trait.DeliveryBuilding == center.Actor && IsCollectorBusyOnDelivering(c))
							occupancy += c.Trait.Info.OccupancyPower;
					}

					if (stuckroad < center.Trait.Info.ToleratedStuckRoad ||
						occupancy < center.Trait.Info.ToleratedOccupancy || bestcenter == null)
						bestcenter = center.Actor;
				}

				return bestcenter;
			}

			if (mobile != null)
			{
				// Find all supply centers and their occupancy count:
				// Note: for non-aircraft, we exclude supply centers with too many collectors clogging the delivery location.
				var accessibleCenters = new Dictionary<CPos, (Actor Actor, int Occupancy)>();
				foreach (var center in centers)
				{
					var stuckroad = 0;
					var occupancy = 0;
					foreach (var c in collectors)
					{
						if (center.Trait.CanStuckRoad(center.Actor, c.Actor))
							stuckroad += c.Trait.Info.StuckRoadPower;

						if (c.Trait.DeliveryBuilding == center.Actor && IsCollectorBusyOnDelivering(c))
							occupancy += c.Trait.Info.OccupancyPower;
					}

					if (stuckroad < center.Trait.Info.ToleratedStuckRoad || occupancy < center.Trait.Info.ToleratedOccupancy)
						accessibleCenters[center.Actor.World.Map.CellContaining(center.Actor.CenterPosition)] = (center.Actor, stuckroad);
				}

				// Start a search from each supply center's delivery location:
				var path = mobile.PathFinder.FindPathToTargetCells(
					self, self.Location, accessibleCenters.Select(r => r.Key), BlockedByActor.None,
					location => accessibleCenters.TryGetValue(location, out var r) ? r.Occupancy : 0);

				if (path.Count > 0)
					return accessibleCenters[path[0]].Actor;

				return null;
			}

			return null;
		}
	}
}
