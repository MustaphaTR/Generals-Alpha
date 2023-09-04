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

using OpenRA.Mods.Common.Activities;

// This class is for debugging on actor tag
namespace OpenRA.Mods.GenSDK.Activities
{
	public class HandleGoods : Wait
	{
		public HandleGoods(int period)
			: base(period) { }

		public HandleGoods(int period, bool interruptible)
			: base(period, interruptible) { }
	}
}
