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
		readonly Color? targetLineColor;

		public FindGoods(Actor self, Color? targetLineColor = null)
		{
			collector = self.Trait<SupplyCollector>();
			collectorInfo = self.Info.TraitInfo<SupplyCollectorInfo>();
			move = self.Trait<IMove>();
			mobile = self.TraitOrDefault<Mobile>();
			this.targetLineColor = targetLineColor;
		}

		public override bool Tick(Actor self)
		{
			if (IsCanceling)
				return true;

			if (collector.CollectionBuilding == null || !collector.CollectionBuilding.IsInWorld || !collectorInfo.CollectionRelationships.HasRelationship(self.Owner.RelationshipWith(collector.CollectionBuilding.Owner)) || collector.CollectionBuilding.Trait<SupplyDock>().IsEmpty)
			{
				collector.CollectionBuilding = collector.ClosestTradeBuilding(self, null);
			}

			if (collector.CollectionBuilding == null || !collector.CollectionBuilding.IsInWorld)
			{
				QueueChild(new Wait(collectorInfo.SearchForCollectionBuildingDelay));
				return false;
			}

			var dock = collector.CollectionBuilding;
			var center = collector.DeliveryBuilding;

			CPos cell;
			var dockTrait = dock.Trait<SupplyDock>();
			var centerTrait = center == null || !center.IsInWorld ? null : center.Trait<SupplyCenter>();
			var offsets = (mobile == null || collectorInfo.IsAircraft) && dockTrait.Info.AircraftCollectionOffsets.Any() ? dockTrait.Info.AircraftCollectionOffsets : dockTrait.Info.CollectionOffsets;
			var deliveryOffsets = centerTrait?.Info.DeliveryOffsets;
			if (mobile != null)
				cell = self.ClosestCell(offsets.Select(c => dock.Location + c).Where(c => mobile.CanEnterCell(c) && (centerTrait == null || !deliveryOffsets.Select(d => center.Location + d).Contains(c))));
			else
				cell = self.ClosestCell(offsets.Select(c => dock.Location + c).Where(c => centerTrait == null || !deliveryOffsets.Select(d => center.Location + d).Contains(c)));

			if (!offsets.Select(c => dock.Location + c).Where(c => centerTrait == null || !deliveryOffsets.Select(d => center.Location + d).Contains(c)).Contains(self.Location))
			{
				QueueChild(move.MoveTo(cell, 2));
				return false;
			}

			if (self.TraitOrDefault<IFacing>() != null)
			{
				if (dockTrait.Info.Facing != null && self.Trait<IFacing>().Facing != dockTrait.Info.Facing.Value)
				{
					QueueChild(new Turn(self, dockTrait.Info.Facing.Value));
					return false;
				}
				else if (dockTrait.Info.Facing == null)
				{
					var facing = (dock.CenterPosition - self.CenterPosition).Yaw;
					if (self.Trait<IFacing>().Facing != facing)
					{
						QueueChild(new Turn(self, facing));
						return false;
					}
				}
			}

			if (!collector.WorkingOnSupply)
			{
				collector.WorkingOnSupply = true;
				QueueChild(new Wait(collectorInfo.CollectionDelay));
				return false;
			}

			var wsb = self.TraitsImplementing<WithSpriteBody>().Where(t => !t.IsTraitDisabled).FirstOrDefault();
			var wsco = self.TraitOrDefault<WithSupplyCollectionOverlay>();
			if (wsb != null && wsco != null && !collector.DeliveryAnimPlayed)
			{
				if (!wsco.Visible)
				{
					wsco.Visible = true;
					wsco.Anim.PlayThen(wsco.Info.Sequence, () => wsco.Visible = false);
					collector.DeliveryAnimPlayed = true;
					QueueChild(new Wait(wsco.Info.WaitDelay));
					return false;
				}
			}

			collector.WorkingOnSupply = false;
			collector.DeliveryAnimPlayed = false;
			var cash = Math.Min(collectorInfo.Capacity - collector.Amount, dockTrait.Amount);
			collector.Amount = cash;
			dockTrait.Amount -= cash;
			collector.CheckConditions(self);
			dockTrait.CheckConditions(dock);

			self.QueueActivity(new DeliverGoods(self));
			return true;
		}

		public override IEnumerable<TargetLineNode> TargetLineNodes(Actor self)
		{
			if (targetLineColor != null && collector.CollectionBuilding != null)
				yield return new TargetLineNode(Target.FromActor(collector.CollectionBuilding), targetLineColor.Value);
		}
	}
}
