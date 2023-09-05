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
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	public class SupplyDockInfo : TraitInfo
	{
		public readonly HashSet<string> SupplyTypes = new() { "supply" };

		[Desc("How much supplies this actor carries.")]
		public readonly int Capacity = 30000;

		[FieldLoader.Require]
		[Desc("Where can the supply collectors can collect the supplies from.")]
		public readonly CVec[] CollectionOffsets = Array.Empty<CVec>();

		[Desc("Where can the aircraft supply collectors can collect the supplies from.")]
		public readonly CVec[] AircraftCollectionOffsets = Array.Empty<CVec>();

		[Desc("Conditions to grant when dock has more than specified amount of supplies.",
			"A dictionary of [integer]: [condition].")]
		public readonly Dictionary<int, string> FullnessConditions = new();

		[Desc("Supplies check all collector reserved at this delay to pickout the invalid one.")]
		public readonly int CheckReservedInterval = 5;

		[Desc("Trade supplies to only one collector in dock at a time.")]
		public readonly bool CollectOneByOne = true;

		[Desc("When a collector is comming and working for collecting (HACK: not waiting), occupancy will be inceased by collector.",
			"Note: only when both `ToleratedOccupancy` and `ToleratedStuckRoad` are reached,",
			"this dock will prevent non-aircraft auto-select this dock, and suggest aircraft not to auto-select this dock")]
		public readonly int ToleratedOccupancy = 6;

		[Desc("When a collector is within `StuckRoadCheckRange`, road stucking will be inceased by collector")]
		public readonly int ToleratedStuckRoad = 9;

		[Desc("Road stucking checking range, and force make way range when entry is stuck.")]
		public readonly WDist StuckRoadCheckRange = WDist.FromCells(3);

		[GrantedConditionReference]
		public IEnumerable<string> LinterFullnessConditions { get { return FullnessConditions.Values; } }

		public override object Create(ActorInitializer init) { return new SupplyDock(init.Self, this); }
	}

	public sealed class SupplyDock : IProvideTooltipInfo, INotifyCreated, ISupplyDock, ITick
	{
		public readonly SupplyDockInfo Info;
		public int Amount;

		readonly Dictionary<int, int> fullnessTokens = new();
		readonly Func<CPos> getDockLocation;
		readonly bool[] airOffsetsTaken;

		// Aircraft use a reserve and unreserve logic to make them dock in different place
		readonly Dictionary<Actor, int> reservedAirs = new();
		Actor collectorInTrade;

		int ticks;

		public SupplyDock(Actor self, SupplyDockInfo info)
		{
			Info = info;
			Amount = Info.Capacity;
			airOffsetsTaken = new bool[info.AircraftCollectionOffsets.Length];
			getDockLocation = () => self.Location;
		}

		void INotifyCreated.Created(Actor self)
		{
			CheckConditions(self);
			ticks = self.World.SharedRandom.Next(0, Info.CheckReservedInterval);
		}

		public bool IsFull { get { return Amount == Info.Capacity; } }
		public bool IsEmpty { get { return Amount == 0; } }
		public int Fullness { get { return Amount * 100 / Info.Capacity; } }

		bool ISupplyDock.IsFull() { return IsFull; }
		bool ISupplyDock.IsEmpty() { return IsEmpty; }
		int ISupplyDock.Fullness() { return Fullness; }

		void ITick.Tick(Actor self)
		{
			if (--ticks > 0)
				return;

			foreach (var a in reservedAirs.Keys)
			{
				if (a.IsDead || !a.IsInWorld)
				{
					if (reservedAirs.Remove(a, out var i))
						airOffsetsTaken[i] = false;
				}
			}
		}

		public CPos? ReservedByAircraft(Actor collector)
		{
			if (reservedAirs.ContainsKey(collector))
				return Info.AircraftCollectionOffsets[reservedAirs[collector]] + getDockLocation();

			if (reservedAirs.Count >= airOffsetsTaken.Length)
				return null;

			var baseCellDist = collector.Location - getDockLocation();
			var minDist = int.MaxValue;
			var bestIndex = 0;
			for (var i = 0; i < airOffsetsTaken.Length; i++)
			{
				if (airOffsetsTaken[i])
					continue;

				var dist = (baseCellDist - Info.AircraftCollectionOffsets[i]).LengthSquared;
				if (dist < minDist)
				{
					minDist = dist;
					bestIndex = i;
				}
			}

			reservedAirs[collector] = bestIndex;
			airOffsetsTaken[bestIndex] = true;
			return Info.AircraftCollectionOffsets[reservedAirs[collector]] + getDockLocation();
		}

		public void UnreservedByAircraft(Actor collector)
		{
			if (reservedAirs.Remove(collector, out var i))
				airOffsetsTaken[i] = false;
		}

		public bool RegisterTrade(Actor self, Actor collector)
		{
			if (!Info.CollectOneByOne || collector == collectorInTrade)
				return true;

			if (collectorInTrade == null || collectorInTrade.IsDead || !collectorInTrade.IsInWorld)
			{
				collectorInTrade = collector;
				return true;
			}

			return false;
		}

		public void UnregisterTrade(Actor self, Actor collector)
		{
			if (!Info.CollectOneByOne)
				return;

			if (collector == collectorInTrade)
				collectorInTrade = null;
		}

		public void ShouldChangeDock(Actor self, Actor collector)
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

				if (c.Trait.CollectionBuilding == self && SupplyCollector.IsCollectorBusyOnCollecting(c))
					occupancy += c.Trait.Info.OccupancyPower;
			}

			if (stuckroad > Info.ToleratedStuckRoad && occupancy > Info.ToleratedOccupancy)
				collectorTrait.FindOtherCollectionBuildingAdvisor = self;
		}

		public bool CanStuckRoad(Actor self, Actor collector)
		{
			if ((self.CenterPosition - collector.CenterPosition).HorizontalLengthSquared <= Info.StuckRoadCheckRange.LengthSquared)
				return true;
			return false;
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

		public bool IsTooltipVisible(Player forPlayer) { return true; }

		public string TooltipText
		{
			get
			{
				return "$" + Amount;
			}
		}
	}
}
