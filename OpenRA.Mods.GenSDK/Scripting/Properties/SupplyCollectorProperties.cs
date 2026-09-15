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

using OpenRA.Mods.GenSDK.Activities;
using OpenRA.Mods.GenSDK.Traits;
using OpenRA.Primitives;
using OpenRA.Scripting;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Scripting
{
	[ScriptPropertyGroup("Movement")]
	public class SupplyCollectorProperties : ScriptActorProperties, Requires<SupplyCollectorInfo>
	{
		readonly SupplyCollector supplyCollector;

		public SupplyCollectorProperties(ScriptContext context, Actor self)
			: base(context, self)
		{
			supplyCollector = self.Trait<SupplyCollector>();
		}

		[Desc("Returns true if the supply collector is full.")]
		public bool IsSupplyFull => supplyCollector.IsFull;

		[Desc("Returns true if the supply collector is empty.")]
		public bool IsSupplyEmpty => supplyCollector.IsEmpty;

		[Desc("Returns the percent fullness of the supply collector.")]
		public int SupplyFullness => supplyCollector.Fullness;

		[ScriptActorPropertyActivity]
		[Desc("Deliver the stored goods to a supply center.")]
		public void DeliverGoods(Actor center = null)
		{
			if (center != null)
				supplyCollector.AssignDeliveryBuilding(center);

			Self.QueueActivity(new DeliverGoods(Self, Color.Green));
		}
	}
}
