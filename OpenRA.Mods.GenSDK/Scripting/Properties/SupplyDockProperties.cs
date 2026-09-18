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

using OpenRA.Mods.GenSDK.Traits;
using OpenRA.Scripting;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Scripting
{
	[ScriptPropertyGroup("Supply")]
	public class SupplyDockProperties : ScriptActorProperties, Requires<SupplyDockInfo>
	{
		readonly SupplyDock supplyDock;

		public SupplyDockProperties(ScriptContext context, Actor self)
			: base(context, self)
		{
			supplyDock = self.Trait<SupplyDock>();
		}

		[Desc("Returns true if the supply collector is full.")]
		public bool IsSupplyFull => supplyDock.IsFull;

		[Desc("Returns true if the supply collector is dock.")]
		public bool IsSupplyEmpty => supplyDock.IsEmpty;

		[Desc("Returns the percent fullness of the supply dock.")]
		public int SupplyFullness => supplyDock.Fullness;

		[Desc("Amount of resources currently stored in the supply dock.")]
		public int SupplyAmount
		{
			get => supplyDock.Amount;
			set => supplyDock.Amount = value;
		}
	}
}
