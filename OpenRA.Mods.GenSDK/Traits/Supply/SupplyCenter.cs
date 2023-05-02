#region Copyright & License Information
/*
 * Copyright 2007-2020 The OpenRA Developers (see AUTHORS)
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
using OpenRA.Mods.Common;
using OpenRA.Mods.Common.Effects;
using OpenRA.Mods.Common.Traits;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	public class SupplyCenterInfo : TraitInfo
	{
		public readonly HashSet<string> SupplyTypes = new HashSet<string> { "supply" };

		[Desc("Store resources in silos. Adds cash directly without storing if set to false.")]
		public readonly bool UseStorage = true;

		[Desc("Discard resources once silo capacity has been reached.")]
		public readonly bool DiscardExcessResources = false;

		[FieldLoader.Require]
		[Desc("Where can the supply collectors can place the supplies.")]
		public readonly CVec[] DeliveryOffsets = new CVec[] { };

		[Desc("Collector faces this way before dropping the supplies; if undefined, faces towards the center of the actor.")]
		public readonly WAngle? Facing = null;

		public readonly bool ShowTicks = true;
		public readonly int TickLifetime = 30;
		public readonly int TickVelocity = 2;
		public readonly int TickRate = 10;

		public override object Create(ActorInitializer init) { return new SupplyCenter(init.Self, this); }
	}

	public class SupplyCenter : ITick, IResourceExchange, INotifyCreated, INotifyOwnerChanged
	{
		readonly Actor self;
		public readonly SupplyCenterInfo Info;
		PlayerResources playerResources;
		RefineryResourceMultiplier[] resourceMultipliers;

		int currentDisplayTick = 0;
		int currentDisplayValue = 0;

		public SupplyCenter(Actor self, SupplyCenterInfo info)
		{
			this.self = self;
			Info = info;
			playerResources = self.Owner.PlayerActor.Trait<PlayerResources>();
			currentDisplayTick = info.TickRate;
		}

		void INotifyCreated.Created(Actor self)
		{
			resourceMultipliers = self.TraitsImplementing<RefineryResourceMultiplier>().ToArray();
		}

		public bool CanGiveResource(int amount) { return !Info.UseStorage || Info.DiscardExcessResources || playerResources.CanGiveResources(amount); }

		public void GiveResource(int amount, string collector)
		{
			amount = Util.ApplyPercentageModifiers(amount, resourceMultipliers.Select(m => m.GetModifier()));

			if (Info.UseStorage)
			{
				if (Info.DiscardExcessResources)
					amount = Math.Min(amount, playerResources.ResourceCapacity - playerResources.Resources);

				playerResources.GiveResources(amount);
			}
			else
				playerResources.GiveCash(amount);

			if (Info.ShowTicks)
				currentDisplayValue += amount;
		}

		void ITick.Tick(Actor self)
		{
			if (Info.ShowTicks && currentDisplayValue > 0 && --currentDisplayTick <= 0)
			{
				var temp = currentDisplayValue;
				if (self.Owner.IsAlliedWith(self.World.RenderPlayer))
					self.World.AddFrameEndTask(w => w.Add(new FloatingText(self.CenterPosition, self.Owner.Color, FloatingText.FormatCashTick(temp), 30)));
				currentDisplayTick = Info.TickRate;
				currentDisplayValue = 0;
			}
		}

		void INotifyOwnerChanged.OnOwnerChanged(Actor self, Player oldOwner, Player newOwner)
		{
			playerResources = newOwner.PlayerActor.Trait<PlayerResources>();
		}
	}
}
