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

using OpenRA.Mods.Common.Traits;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	[Desc("Fake power that does nothing but play activation voices/sounds when activated.")]
	public class FakePowerInfo : SupportPowerInfo
	{
		public override object Create(ActorInitializer init) { return new FakePower(init.Self, this); }
	}

	public class FakePower : SupportPower, IResolveOrder
	{
		public readonly FakePowerInfo FakePowerInfo;

		public FakePower(Actor self, FakePowerInfo info)
			: base(self, info)
		{
			FakePowerInfo = info;
		}

		public override void SelectTarget(Actor self, string order, SupportPowerManager manager)
		{
			self.World.IssueOrder(new Order(order, manager.Self, false));
		}

		public override void Activate(Actor self, Order order, SupportPowerManager manager)
		{
			base.Activate(self, order, manager);

			Activation(self);
		}

		void IResolveOrder.ResolveOrder(Actor self, Order order)
		{
			if (order.OrderString.Contains(Info.OrderName))
				Activation(self);
		}

		void Activation(Actor self)
		{
			PlayLaunchSounds();
			if (self.Owner.IsAlliedWith(self.World.RenderPlayer))
				Game.Sound.Play(SoundType.World, FakePowerInfo.LaunchSound);
			else
				Game.Sound.Play(SoundType.World, FakePowerInfo.IncomingSound);
		}
	}
}
