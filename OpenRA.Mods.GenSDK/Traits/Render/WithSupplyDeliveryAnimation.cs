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

using OpenRA.Mods.Common.Traits.Render;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	public class WithSupplyDeliveryAnimationInfo : TraitInfo<WithSupplyDeliveryAnimation>, Requires<WithSpriteBodyInfo>
	{
		[SequenceReference]
		[Desc("Displayed when delivering the supplies to supply center.")]
		public readonly string DeliverySequence = "deliver";

		[Desc("Wait this much extra on the delivery position for overlay to play.",
		"I couldn't manage to code something automatic.")]
		public readonly int WaitDelay = 25;
	}

	public class WithSupplyDeliveryAnimation { }
}
