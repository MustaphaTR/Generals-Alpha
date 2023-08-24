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
	[Desc("Resupplies a supply dock.")]
	public class ResupplyDockInfo : PausableConditionalTraitInfo, Requires<SupplyDockInfo>
	{
		[Desc("Resupply time in ticks per Amount.")]
		public readonly int Delay = 50;

		[Desc("How much supply is reloaded after Delay.")]
		public readonly int Amount = 600;

		[Desc("Play this sound each time resupply happens.")]
		public readonly string Sound = null;

		public override object Create(ActorInitializer init) { return new ResupplyDock(this); }
	}

	public class ResupplyDock : PausableConditionalTrait<ResupplyDockInfo>, ITick, ISync
	{
		SupplyDock supplyDock;

		[Sync]
		int remainingTicks;

		public ResupplyDock(ResupplyDockInfo info)
			: base(info) { }

		protected override void Created(Actor self)
		{
			supplyDock = self.Trait<SupplyDock>();
			remainingTicks = Info.Delay;
			base.Created(self);
		}

		void ITick.Tick(Actor self)
		{
			if (IsTraitPaused || IsTraitDisabled)
				return;

			if (!supplyDock.IsFull && --remainingTicks == 0)
			{
				remainingTicks = Info.Delay;
				if (!string.IsNullOrEmpty(Info.Sound))
					Game.Sound.PlayToPlayer(SoundType.World, self.Owner, Info.Sound, self.CenterPosition);

				supplyDock.Amount += Info.Amount;
				if (supplyDock.Amount > supplyDock.Info.Capacity)
					supplyDock.Amount = supplyDock.Info.Capacity;
			}
		}

		protected override void TraitDisabled(Actor self)
		{
			remainingTicks = Info.Delay;
		}
	}
}
