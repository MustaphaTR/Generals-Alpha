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
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	public class GrantConditionWhileCollectingSuppliesInfo : TraitInfo, Requires<SupplyCollectorInfo>
	{
		[FieldLoader.Require]
		[GrantedConditionReference]
		[Desc("The condition to grant")]
		public readonly string Condition = null;

		public override object Create(ActorInitializer init) { return new GrantConditionWhileCollectingSupplies(this); }
	}

	public class GrantConditionWhileCollectingSupplies : ITick
	{
		readonly GrantConditionWhileCollectingSuppliesInfo info;

		int token = Actor.InvalidConditionToken;

		public GrantConditionWhileCollectingSupplies(GrantConditionWhileCollectingSuppliesInfo info)
		{
			this.info = info;
		}

		void GrantCondition(Actor self, string cond)
		{
			if (string.IsNullOrEmpty(cond))
				return;

			token = self.GrantCondition(cond);
		}

		void RevokeCondition(Actor self)
		{
			if (token == Actor.InvalidConditionToken)
				return;

			token = self.RevokeCondition(token);
		}

		bool IsValidActivity(Actor self)
		{
			if (self.CurrentActivity is HandleGoods || self.CurrentActivity is DeliverGoods || self.CurrentActivity is FindGoods)
				return true;

			return false;
		}

		void ITick.Tick(Actor self)
		{
			if (IsValidActivity(self))
			{
				if (token == Actor.InvalidConditionToken)
					GrantCondition(self, info.Condition);
			}
			else
			{
				if (token != Actor.InvalidConditionToken)
					RevokeCondition(self);
			}
		}
	}
}
