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
using OpenRA.Activities;
using OpenRA.Mods.Common;
using OpenRA.Mods.Common.Activities;
using OpenRA.Mods.Common.Traits;
using OpenRA.Mods.Common.Traits.Render;
using OpenRA.Mods.GenSDK.Traits;
using OpenRA.Primitives;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Activities
{
	public class FindGoods : Activity
	{
		readonly SupplyCollector collector;
		readonly SupplyCollectorInfo collectorInfo;
		readonly IMove move;
		readonly Mobile mobile;
		readonly Aircraft aircraft;
		readonly Color? targetLineColor;

		enum AirDockingStage { GetToDock, FindDockCell, Docking, Docked }

		AirDockingStage airDockingStage = AirDockingStage.GetToDock;
		int blockAtEntry = 0;
		CPos? targetcell = null;

		public FindGoods(Actor self, Color? targetLineColor = null)
		{
			collector = self.Trait<SupplyCollector>();
			collectorInfo = self.Info.TraitInfo<SupplyCollectorInfo>();
			move = self.Trait<IMove>();
			mobile = self.TraitOrDefault<Mobile>();
			aircraft = self.TraitOrDefault<Aircraft>();
			this.targetLineColor = targetLineColor;
		}

		void WaitAtParkingZone(Actor self, int waitDuration, Actor center, SupplyCenter centerTriat)
		{
			if (centerTriat == null || !centerTriat.AtNoParkingZone(center, self.Location))
				QueueChild(new Wait(waitDuration));
			else
				QueueChild(new Nudge(self));
		}

		public override bool Tick(Actor self)
		{
			var isAir = aircraft != null;
			if (isAir)
				aircraft.EnableRepulse();

			var dock = collector.CollectionBuilding;
			var dockTrait = dock != null && !dock.IsDead ? dock.Trait<SupplyDock>() : null;

			if (IsCanceling)
			{
				if (isAir)
					dockTrait?.UnreservedByAircraft(self);
				dockTrait?.UnregisterTrade(dock, self);
				collector.WorkingAtPortState = WorkingAtPortState.None;
				return true;
			}

			// Hack: Prevent stuck at DeliveryBuilding.
			var center = collector.DeliveryBuilding;
			var centerTrait = (center == null || center.IsDead || !center.IsInWorld) ? null : center.Trait<SupplyCenter>();

			// Check if we blocked at the center's entry (no-aircraft)
			if (mobile != null && centerTrait != null)
			{
				// Oops, we just block the center's entry!
				if (centerTrait.AtDeliveryZone(center, self.Location))
				{
					blockAtEntry++;
					if (blockAtEntry > centerTrait.Info.ForceMakeWayDelay)
					{
						blockAtEntry = 0;
						centerTrait.HandlingStuck(center, self);
					}
					else
						QueueChild(new Nudge(self));

					return false;
				}
			}

			// Check if supply dock is valid. If not we try find a new one
			if (dockTrait == null)
			{
				targetcell = null;
				airDockingStage = AirDockingStage.GetToDock;
				collector.WorkingAtPortState = WorkingAtPortState.None;

				dock = collector.ClosestTradeBuilding(self, null);
				collector.FindOtherCollectionBuildingAdvisor = null;

				if (dock == null)
				{
					collector.AssignCollectionBuilding(null);
					if (collector.AllColletionDepleted)
					{
						Cancel(self, true);
						return false;
					}

					WaitAtParkingZone(self, collectorInfo.SearchForCollectionBuildingDelay, center, centerTrait);
				}
				else
					collector.AssignCollectionBuilding(dock);

				return false;
			}
			else if (!dock.IsInWorld || dockTrait.IsEmpty || collector.FindOtherCollectionBuildingAdvisor == dock || !collectorInfo.CollectionRelationships.HasRelationship(self.Owner.RelationshipWith(dock.Owner)))
			{
				if (isAir)
					dockTrait.UnreservedByAircraft(self);
				dockTrait.UnregisterTrade(dock, self);
				targetcell = null;
				airDockingStage = AirDockingStage.GetToDock;
				collector.WorkingAtPortState = WorkingAtPortState.None;

				dock = collector.ClosestTradeBuilding(self, null);
				collector.FindOtherCollectionBuildingAdvisor = null;

				if (dock == null)
				{
					collector.AssignCollectionBuilding(null);
					if (collector.AllColletionDepleted)
					{
						Cancel(self, true);
						return false;
					}

					WaitAtParkingZone(self, collectorInfo.SearchForCollectionBuildingDelay, center, centerTrait);
					return false;
				}
				else
				{
					// For Perf: leave rest of work next tick.
					collector.AssignCollectionBuilding(dock);
					return false;
				}
			}

			switch (collector.WorkingAtPortState)
			{
				case WorkingAtPortState.None:
					if (self.Location == targetcell && (mobile != null || (isAir && airDockingStage == AirDockingStage.Docking)))
					{
						collector.WorkingAtPortState = WorkingAtPortState.Registering;
						if (isAir)
							airDockingStage = AirDockingStage.Docked;
						return false;
					}

					var dockableCells = dockTrait.Info.CollectionOffsets.Select(c => dock.Location + c).ToList();

					// Move to supply dock (collector is non-aircraft)
					if (mobile != null)
					{
						// Find nearest unblocked port.
						var bestdist = int.MaxValue;
						foreach (var c in dockableCells)
						{
							if (c == self.Location)
							{
								targetcell = c;
								break;
							}

							if (!targetcell.HasValue || ((c - self.Location).LengthSquared < bestdist && mobile.CanEnterCell(c)))
							{
								targetcell = c;
								bestdist = (c - self.Location).LengthSquared;
							}
						}

						if (targetcell != null && targetcell != self.Location)
							QueueChild(move.MoveTo(targetcell.Value, 2));
						else if (!targetcell.HasValue)
							WaitAtParkingZone(self, collectorInfo.WaitInlineDuration, center, centerTrait);

						return false;
					}

					// Move to supply dock (collector is aircraft)
					if (isAir)
					{
						switch (airDockingStage)
						{
							case AirDockingStage.GetToDock:
								aircraft.DisableRepulse();
								targetcell = self.ClosestCell(dockableCells);
								airDockingStage = AirDockingStage.FindDockCell;
								QueueChild(move.MoveTo(targetcell.Value, 2));
								return false;

							case AirDockingStage.FindDockCell:
								targetcell = dockTrait.ReservedByAircraft(self);
								if (!targetcell.HasValue)
								{
									QueueChild(new Wait(collectorInfo.WaitInlineDuration));
									return false;
								}
								else
								{
									airDockingStage = AirDockingStage.Docking;
									return false;
								}

							case AirDockingStage.Docking:
								aircraft.DisableRepulse();
								airDockingStage = AirDockingStage.Docking;
								QueueChild(move.MoveTo(targetcell.Value, 2));
								return false;
						}
					}

					return false;

				case WorkingAtPortState.Registering:
					// aircraft collector ignore repulsing force in this stage
					if (isAir)
						aircraft.DisableRepulse();

					// Fallback to moving stage if get teleported
					if (self.Location != targetcell)
					{
						collector.WorkingAtPortState = WorkingAtPortState.None;
						airDockingStage = AirDockingStage.GetToDock;
						return false;
					}

					// Turns to dock facing
					if (self.TraitOrDefault<IFacing>() != null)
					{
						switch (collectorInfo.FacingWhenDockAtSupplyPile)
						{
							case FacingWhenDock.Any:
								break;
							case FacingWhenDock.TowardsTarget:
								var facing = (dock.CenterPosition - self.CenterPosition).Yaw;
								if (self.Trait<IFacing>().Facing != facing)
								{
									QueueChild(new Turn(self, facing));
									return false;
								}

								break;
							case FacingWhenDock.Specific:
								if (self.Trait<IFacing>().Facing != collectorInfo.SpecificFacingOnSupply)
								{
									QueueChild(new Turn(self, collectorInfo.SpecificFacingOnSupply));
									return false;
								}

								break;
						}
					}

					if (!dockTrait.RegisterTrade(dock, self))
					{
						QueueChild(new Wait(collectorInfo.WaitForTradeDuration));
						return false;
					}

					collector.WorkingAtPortState = WorkingAtPortState.Working;
					QueueChild(new PrepareCollect(collectorInfo.CollectionDelay));
					return false;

				case WorkingAtPortState.Working:
					// aircraft collector ignore repulsing force in this stage
					if (isAir)
						aircraft.DisableRepulse();

					collector.WorkingAtPortState = WorkingAtPortState.Done;

					// Perform collect effect, if we have
					var wsb = self.TraitsImplementing<WithSpriteBody>().Where(t => !t.IsTraitDisabled).FirstOrDefault();
					var wsco = self.TraitOrDefault<WithSupplyCollectionOverlay>();
					if (wsb != null && wsco != null)
					{
						if (!wsco.Visible)
						{
							wsco.Visible = true;
							wsco.Anim.PlayThen(wsco.Info.Sequence, () => wsco.Visible = false);
							QueueChild(new HandleGoods(wsco.Info.WaitDelay));
						}
					}

					return false;

				case WorkingAtPortState.Done:
					var cash = Math.Min(collectorInfo.Capacity - collector.Amount, dockTrait.Amount);
					collector.Amount += cash;
					dockTrait.Amount -= cash;
					collector.CheckConditions(self);
					dockTrait.CheckConditions(dock);

					// Rest the working status of collector
					collector.WorkingAtPortState = WorkingAtPortState.None;
					dockTrait.UnregisterTrade(dock, self);
					if (isAir)
					{
						dockTrait.UnreservedByAircraft(self);
						aircraft.EnableRepulse();
					}

					dockTrait.ShouldChangeDock(dock, self);
					self.QueueActivity(new DeliverGoods(self));
					return true;
			}

			// Note: Unless there is a bug, we should not reach here.
			return false;
		}

		public override IEnumerable<TargetLineNode> TargetLineNodes(Actor self)
		{
			if (targetLineColor != null)
			{
				if (targetcell.HasValue)
					yield return new TargetLineNode(Target.FromCell(self.World, targetcell.Value), targetLineColor.Value);
				else if (collector.CollectionBuilding != null)
					yield return new TargetLineNode(Target.FromActor(collector.CollectionBuilding), targetLineColor.Value);
			}
		}
	}
}
