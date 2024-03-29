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

namespace OpenRA.Mods.GenSDK.Activities
{
	// This class is for debugging on actor tag
	public class PrepareCollect : Wait
	{
		public PrepareCollect(int period)
			: base(period) { }

		public PrepareCollect(int period, bool interruptible)
			: base(period, interruptible) { }
	}
}
