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
	class DeliverGoods : Activity
	{
		readonly SupplyCollector collector;
		readonly SupplyCollectorInfo collectorInfo;
		readonly IMove move;
		readonly Mobile mobile;
		readonly Aircraft aircraft;
		readonly Color? targetLineColor;
		CPos? targetcell = null;

		void WaitAtParkingZone(Actor self, int waitDuration, Actor center, SupplyCenter centerTriat)
		{
			if (centerTriat == null || !centerTriat.AtNoParkingZone(center, self.Location))
				QueueChild(new Wait(waitDuration));
			else
				QueueChild(new Nudge(self));
		}

		public DeliverGoods(Actor self, Color? targetLineColor = null)
		{
			collector = self.Trait<SupplyCollector>();
			collectorInfo = self.Info.TraitInfo<SupplyCollectorInfo>();
			move = self.Trait<IMove>();
			mobile = self.TraitOrDefault<Mobile>();
			aircraft = self.TraitOrDefault<Aircraft>();
			this.targetLineColor = targetLineColor;
		}

		public override bool Tick(Actor self)
		{
			var isAir = aircraft != null;
			if (isAir)
				aircraft.EnableRepulse();

			var center = collector.DeliveryBuilding;
			var centerTrait = center != null && !center.IsDead ? center.Trait<SupplyCenter>() : null;

			if (IsCanceling)
			{
				centerTrait?.UnregisterTrade(center, self);
				collector.WorkingAtPortState = WorkingAtPortState.None;
				return true;
			}

			// No goods? then we go find some.
			var amount = collector.Amount;
			if (amount <= 0)
			{
				centerTrait?.UnregisterTrade(center, self);
				collector.WorkingAtPortState = WorkingAtPortState.None;
				self.QueueActivity(new FindGoods(self));
				return true;
			}

			// Check if supply center is valid. If not we try find new one
			if (centerTrait == null)
			{
				targetcell = null;
				collector.WorkingAtPortState = WorkingAtPortState.None;

				center = collector.ClosestDeliveryBuilding(self, null);
				collector.FindOtherDeliveryBuildingAdvisor = null;

				if (center == null)
				{
					collector.DeliveryBuilding = null;
					QueueChild(new Wait(collectorInfo.SearchForDeliveryBuildingDelay));
					return false;
				}
				else
					collector.DeliveryBuilding = center;

				return false;
			}
			else if (!center.IsInWorld || collector.FindOtherDeliveryBuildingAdvisor == center || !collectorInfo.DeliveryRelationships.HasRelationship(self.Owner.RelationshipWith(center.Owner)))
			{
				targetcell = null;
				centerTrait.UnregisterTrade(center, self);
				collector.WorkingAtPortState = WorkingAtPortState.None;

				center = collector.ClosestDeliveryBuilding(self, null);
				collector.FindOtherDeliveryBuildingAdvisor = null;

				if (center == null)
				{
					collector.DeliveryBuilding = null;
					QueueChild(new Wait(collectorInfo.SearchForDeliveryBuildingDelay));
					return false;
				}
				else
				{
					// For Perf: leave rest of work next tick.
					collector.DeliveryBuilding = center;
					return false;
				}
			}

			switch (collector.WorkingAtPortState)
			{
				case WorkingAtPortState.None:
					if (self.Location == targetcell)
					{
						collector.WorkingAtPortState = WorkingAtPortState.Registering;
						return false;
					}

					var dockableCells = centerTrait.Info.DeliveryOffsets.Select(c => center.Location + c);

					// Move to supply center (collector is non-aircraft)
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

					// Move to supply center (collector is aircraft)
					if (isAir)
					{
						targetcell = self.ClosestCell(dockableCells);

						if (targetcell != null)
						{
							aircraft.DisableRepulse();
							QueueChild(move.MoveTo(targetcell.Value, 2));
						}
						else
							QueueChild(new Wait(collectorInfo.WaitInlineDuration));

						return false;
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
						return false;
					}

					// Turns to dock facing
					if (self.Trait<IFacing>() != null)
					{
						switch (collectorInfo.FacingWhenDockAtSupplyCenter)
						{
							case FacingWhenDock.Any:
								break;
							case FacingWhenDock.TowardsTarget:
								var facing = (center.CenterPosition - self.CenterPosition).Yaw;
								if (self.Trait<IFacing>().Facing != facing)
								{
									QueueChild(new Turn(self, facing));
									return false;
								}

								break;
							case FacingWhenDock.Specific:
								if (self.Trait<IFacing>().Facing != collectorInfo.SpecificFacingOnCenter)
								{
									QueueChild(new Turn(self, collectorInfo.SpecificFacingOnCenter));
									return false;
								}

								break;
						}
					}

					if (!centerTrait.RegisterTrade(center, self))
					{
						QueueChild(new Wait(collectorInfo.WaitForTradeDuration));
						return false;
					}

					collector.WorkingAtPortState = WorkingAtPortState.Working;
					QueueChild(new PrepareDelivery(collectorInfo.DeliveryDelay));
					return false;

				case WorkingAtPortState.Working:
					// aircraft collector ignore repulsing force in this stage
					if (isAir)
						aircraft.DisableRepulse();
					if (centerTrait.CanGiveResource(amount))
					{
						collector.WorkingAtPortState = WorkingAtPortState.Done;

						// Perform delivery effect, if we have
						var wsb = self.TraitsImplementing<WithSpriteBody>().Where(t => !t.IsTraitDisabled).FirstOrDefault();
						var wsda = self.Info.TraitInfoOrDefault<WithSupplyDeliveryAnimationInfo>();
						var rs = self.TraitOrDefault<RenderSprites>();
						if (rs != null && wsb != null && wsda != null)
						{
							wsb.PlayCustomAnimation(self, wsda.DeliverySequence);
							QueueChild(new HandleGoods(wsda.WaitDelay));
						}

						var wsdo = self.TraitOrDefault<WithSupplyDeliveryOverlay>();
						if (wsb != null && wsdo != null)
						{
							if (!wsdo.Visible)
							{
								wsdo.Visible = true;
								wsdo.Anim.PlayThen(wsdo.Info.Sequence, () => wsdo.Visible = false);
								QueueChild(new HandleGoods(wsdo.Info.WaitDelay));
							}
						}
					}
					else
						QueueChild(new Wait(collectorInfo.DeliveryDelay));

					return false;

				case WorkingAtPortState.Done:
					var amountToGive = Util.ApplyPercentageModifiers(amount, collector.ResourceMultipliers.Select(m => m.GetResourceValueModifier()));
					centerTrait.GiveResource(amountToGive, self.Info.Name);

					collector.Amount = 0;
					collector.CheckConditions(self);

					// Rest the working status of collector
					collector.WorkingAtPortState = WorkingAtPortState.None;
					centerTrait.UnregisterTrade(center, self);
					if (isAir)
						aircraft.EnableRepulse();

					centerTrait.ShouldChangeCenter(center, self);
					self.QueueActivity(new FindGoods(self));
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
				else if (collector.DeliveryBuilding != null)
					yield return new TargetLineNode(Target.FromActor(collector.DeliveryBuilding), targetLineColor.Value);
			}
		}
	}
}
