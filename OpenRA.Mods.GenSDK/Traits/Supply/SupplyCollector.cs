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
using OpenRA.Mods.GenSDK.Activities;
using OpenRA.Mods.GenSDK.Orders;
using OpenRA.Primitives;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	public class SupplyCollectorInfo : TraitInfo
	{
		public readonly HashSet<string> SupplyTypes = new HashSet<string> { "supply" };

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

		[Desc("Automatically scan for trade building when created.")]
		public readonly bool SearchOnCreation = true;

		[Desc("How much cash can this actor can carry.")]
		public readonly int Capacity = 300;

		[Desc("Find a new supply center to unload at if more than this many collectors are already waiting.")]
		public readonly int MaxDeliveryQueue = 3;

		[Desc("The pathfinding cost penalty applied for each collector waiting to unload at a supply center.")]
		public readonly int DeliveryQueueCostModifier = 12;

		[Desc("Multiply dock's CollectionOffset count with this to determine how much of this unit can wait before looking for another dock.",
			"Using 5 for infantry is recommended since there can be 5 in a cell.")]
		public readonly int CollectionQueueMultiplier = 1;

		[Desc("The pathfinding cost penalty applied for each collector waiting to load at a supply dock.")]
		public readonly int CollectionQueueCostModifier = 6;

		[Desc("Go to AircraftCollectionOffsets of supply dock, despite having Mobile trait.")]
		public readonly bool IsAircraft = false;

		[Desc("Conditions to grant when collector has more than specified amount of supplies.",
			"A dictionary of [integer]: [condition].")]
		public readonly Dictionary<int, string> FullnessConditions = new Dictionary<int, string>();

		[GrantedConditionReference]
		public IEnumerable<string> LinterFullnessConditions { get { return FullnessConditions.Values; } }

		[VoiceReference]
		public readonly string CollectVoice = null;

		[VoiceReference]
		public readonly string DeliverVoice = null;

		public override object Create(ActorInitializer init) { return new SupplyCollector(init.Self, this); }
	}

	public class SupplyCollector : IIssueOrder, IResolveOrder, IOrderVoice, ISync, INotifyCreated, INotifyIdle, INotifyBlockingMove, ISupplyCollector
	{
		public readonly SupplyCollectorInfo Info;
		readonly Mobile mobile;
		readonly Actor self;

		public int Amount;
		int ISupplyCollector.Amount() { return Amount; }

		bool idleSmart = true;
		public bool Waiting = false;
		public bool DeliveryAnimPlayed = false;
		public IResourceValueModifier[] ResourceMultipliers;

		[Sync]
		public Actor DeliveryBuilding = null;

		[Sync]
		public Actor CollectionBuilding = null;

		readonly Dictionary<int, int> fullnessTokens = new Dictionary<int, int>();

		public SupplyCollector(Actor self, SupplyCollectorInfo info)
		{
			this.self = self;
			Info = info;
			mobile = self.TraitOrDefault<Mobile>();

			Amount = 0;
		}

		void INotifyCreated.Created(Actor self)
		{
			ResourceMultipliers = self.TraitsImplementing<IResourceValueModifier>().ToArray();
			if (Info.SearchOnCreation)
				self.QueueActivity(new FindGoods(self, Color.Green));

			CheckConditions(self);
		}

		void INotifyBlockingMove.OnNotifyBlockingMove(Actor self, Actor blocking)
		{
			// If I'm just waiting around then get out of the way:
			if (self.IsIdle)
			{
				self.CancelActivity();

				var cell = self.Location;
				var moveTo = mobile.NearestMoveableCell(cell, 2, 5);
				self.QueueActivity(mobile.MoveTo(moveTo, 0, targetLineColor: Color.Green));
				self.ShowTargetLines();

				if (IsEmpty)
				{
					self.QueueActivity(new FindGoods(self, Color.Green));
				}
				else
				{
					self.QueueActivity(new DeliverGoods(self, Color.Green));
				}
			}
		}

		void INotifyIdle.TickIdle(Actor self)
		{
			// Should we be intelligent while idle?
			if (!idleSmart) return;

			if (IsEmpty)
			{
				self.QueueActivity(new FindGoods(self, Color.Green));
			}
			else
			{
				self.QueueActivity(new DeliverGoods(self, Color.Green));
			}
		}

		public bool IsFull { get { return Amount == Info.Capacity; } }
		public bool IsEmpty { get { return Amount == 0; } }
		public int Fullness { get { return Amount * 100 / Info.Capacity; } }

		public IEnumerable<IOrderTargeter> Orders
		{
			get
			{
				yield return new GenericTargeter<BuildingInfo>("Collect", 5,
					a => IsEmpty && a.TraitOrDefault<SupplyDock>() != null && Info.SupplyTypes.Overlaps(a.Trait<SupplyDock>().Info.SupplyTypes) && !a.Trait<SupplyDock>().IsEmpty && (Info.CollectionRelationships.HasRelationship(self.Owner.RelationshipWith(a.Owner))),
					a => "enter");
				yield return new GenericTargeter<BuildingInfo>("Deliver", 5,
					a => !IsEmpty && a.TraitOrDefault<SupplyCenter>() != null && Info.SupplyTypes.Overlaps(a.Trait<SupplyCenter>().Info.SupplyTypes) && (Info.DeliveryRelationships.HasRelationship(self.Owner.RelationshipWith(a.Owner))),
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

				idleSmart = true;
				Waiting = false;
				DeliveryAnimPlayed = false;

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

				idleSmart = true;
				Waiting = false;
				DeliveryAnimPlayed = false;

				var next = new DeliverGoods(self, Color.Green);
				self.QueueActivity(order.Queued, next);
				self.ShowTargetLines();
			}
			else if (order.OrderString == "Stop" || order.OrderString == "Move")
			{
				// Turn off idle smarts to obey the stop/move:
				idleSmart = false;
				Waiting = false;
				DeliveryAnimPlayed = false;
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

		bool IsAcceptableTradeBuilding(Actor supplyDock)
		{
			var dock = supplyDock.Trait<SupplyDock>();
			return Info.SupplyTypes.Overlaps(dock.Info.SupplyTypes) && !dock.IsEmpty && Info.CollectionRelationships.HasRelationship(self.Owner.RelationshipWith(supplyDock.Owner));
		}

		public Actor ClosestTradeBuilding(Actor self, Actor ignore)
		{
			// Find all supply docks and their occupancy count:
			// Exclude supply docks with too many collectors clogging the delivery location.
			var docks = self.World.ActorsWithTrait<SupplyDock>()
				.Where(a => a.Actor != ignore && IsAcceptableTradeBuilding(a.Actor))
				.Select(a => new
				{
					Location = a.Actor.World.Map.CellContaining(a.Actor.CenterPosition),
					Actor = a.Actor,
					Trait = a.Trait,
					Occupancy = self.World.ActorsHavingTrait<SupplyCollector>(c => c.CollectionBuilding == a.Actor && (c.Info.IsAircraft == Info.IsAircraft || !c.CollectionBuilding.Trait<SupplyDock>().Info.AircraftCollectionOffsets.Any())).Count()
				})
				.Where(a => a.Occupancy < (Info.IsAircraft ? a.Trait.Info.AircraftCollectionOffsets.Count() : a.Trait.Info.CollectionOffsets.Count()) * Info.CollectionQueueMultiplier)
				.ToDictionary(a => a.Location);

			if (mobile == null)
			{
				if (docks.Count == 0)
					return null;

				return docks.Values
					.Select(a => a.Actor)
					.MinByOrDefault(a => (a.CenterPosition - self.CenterPosition).LengthSquared);
			}

			// Start a search from each supply dock's collection location:
			var path = mobile.PathFinder.FindPathToTargetCells(
				self, self.Location, docks.Select(r => r.Key), BlockedByActor.None,
				location =>
				{
					if (!docks.ContainsKey(location))
						return 0;

					// Prefer supply dock with less occupancy (multiplier is to offset distance cost):
					var occupancy = docks[location].Occupancy;
					return occupancy * Info.CollectionQueueCostModifier;
				});

			if (path.Count > 0)
				return docks[path[0]].Actor;

			return null;
		}

		bool IsAcceptableDeliveryBuilding(Actor supplyCenter)
		{
			return Info.SupplyTypes.Overlaps(supplyCenter.Trait<SupplyCenter>().Info.SupplyTypes) && Info.DeliveryRelationships.HasRelationship(self.Owner.RelationshipWith(supplyCenter.Owner));
		}

		public Actor ClosestDeliveryBuilding(Actor self, Actor ignore)
		{
			// Find all supply centers and their occupancy count:
			// Exclude supply centers with too many collectors clogging the delivery location.
			var centers = self.World.ActorsWithTrait<SupplyCenter>()
				.Where(a => a.Actor != ignore && IsAcceptableDeliveryBuilding(a.Actor))
				.Select(a => new
				{
					Location = a.Actor.World.Map.CellContaining(a.Actor.CenterPosition),
					Actor = a.Actor,
					Occupancy = self.World.ActorsHavingTrait<SupplyCollector>(c => c.DeliveryBuilding == a.Actor).Count()
				})
				.Where(r => r.Occupancy < Info.MaxDeliveryQueue)
				.ToDictionary(r => r.Location);

			if (mobile == null)
			{
				if (centers.Count == 0)
					return null;

				return centers.Values
					.Select(r => r.Actor)
					.MinByOrDefault(a => (a.CenterPosition - self.CenterPosition).LengthSquared);
			}

			// Start a search from each supply center's delivery location:
			var path = mobile.PathFinder.FindPathToTargetCells(
				self, self.Location, centers.Select(r => r.Key), BlockedByActor.None,
				location =>
				{
					if (!centers.ContainsKey(location))
						return 0;

					// Prefer supply center with less occupancy (multiplier is to offset distance cost):
					var occupancy = centers[location].Occupancy;
					return occupancy * Info.DeliveryQueueCostModifier;
				});

			if (path.Count > 0)
				return centers[path[0]].Actor;

			return null;
		}
	}
}
