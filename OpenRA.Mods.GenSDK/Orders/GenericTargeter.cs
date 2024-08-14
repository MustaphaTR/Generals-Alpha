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
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Orders
{
	public class GenericTargeter<T> : IOrderTargeter where T : TraitInfo
	{
		readonly Func<Actor, bool> canTarget;
		readonly Func<Actor, string> useCursor;

		public GenericTargeter(string order, int priority, Func<Actor, bool> canTarget, Func<Actor, string> useCursor)
		{
			OrderID = order;
			OrderPriority = priority;
			this.canTarget = canTarget;
			this.useCursor = useCursor;
		}

		public string OrderID { get; }
		public int OrderPriority { get; }

		public bool CanTarget(Actor self, in Target target, ref TargetModifiers modifiers, ref string cursor)
		{
			var type = target.Type;
			if (type != TargetType.Actor && type != TargetType.FrozenActor)
				return false;

			IsQueued = modifiers.HasModifier(TargetModifiers.ForceQueue);

			var actor = type == TargetType.FrozenActor ? target.FrozenActor.Actor : target.Actor;
			/* var owner = actor.Owner;
			var playerRelationship = self.Owner.RelationshipWith(owner); */

			return CanTargetActor(self, actor, modifiers, ref cursor);
		}

		public virtual bool IsQueued { get; protected set; }

		public bool TargetOverridesSelection(Actor self, in Target target, List<Actor> actorsAt, CPos xy, TargetModifiers modifiers) { return true; }

		public bool CanTargetActor(Actor self, in Actor target, TargetModifiers modifiers, ref string cursor)
		{
			if (!target.Info.HasTraitInfo<T>() || !canTarget(target))
				return false;

			cursor = useCursor(target);
			return true;
		}
	}
}
