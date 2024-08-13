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

using System.Collections.Generic;
using System.Linq;
using OpenRA.Mods.Common.Traits;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	[Desc("Grants a condition to the SupplyCollectors assigned to this SupplyDock or SupplyCenter.")]
	public class GrantExternalConditionToAssignedCollectorsInfo : ConditionalTraitInfo
	{
		[FieldLoader.Require]
		[Desc("Condition granted to assigned actors.")]
		public readonly string Condition = null;

		public override void RulesetLoaded(Ruleset rules, ActorInfo ai)
		{
			if (!ai.HasTraitInfo<SupplyCenterInfo>() && !ai.HasTraitInfo<SupplyDockInfo>())
				throw new YamlException("'GrantExternalConditionToAssignedCollectors' requies either 'SupplyCenter' or 'SupplyDock' traits on the actor.");

			base.RulesetLoaded(rules, ai);
		}

		public override object Create(ActorInitializer init) { return new GrantExternalConditionToAssignedCollectors(init.Self, this); }
	}

	public class GrantExternalConditionToAssignedCollectors : ConditionalTrait<GrantExternalConditionToAssignedCollectorsInfo>, INotifySupplyCollectorAssigned,
		INotifyKilled, INotifyActorDisposing
	{
		readonly Actor self;
		readonly Dictionary<Actor, int> tokens = new();

		public GrantExternalConditionToAssignedCollectors(Actor self, GrantExternalConditionToAssignedCollectorsInfo info)
			: base(info)
		{
			this.self = self;
		}

		public void HandleCondition(Actor target, Actor collector, bool forceRevoke = false)
		{
			if (IsTraitDisabled && !forceRevoke)
				return;

			var externalCondition = collector.TraitsImplementing<ExternalCondition>().FirstOrDefault(t => t.Info.Condition == Info.Condition && t.CanGrantCondition(self));
			if (externalCondition == null)
				return;

			if ((forceRevoke || target == null || target != self) && tokens.ContainsKey(collector))
			{
				if (externalCondition.TryRevokeCondition(collector, self, tokens[collector]))
					tokens.Remove(collector);
			}
			else
				tokens.Add(collector, externalCondition.GrantCondition(collector, self));
		}

		void INotifySupplyCollectorAssigned.AssignedToSupplyCenter(Actor collector, Actor center)
		{
			HandleCondition(center, collector);
		}

		void INotifySupplyCollectorAssigned.AssignedToSupplyDock(Actor collector, Actor dock)
		{
			HandleCondition(dock, collector);
		}

		void INotifyKilled.Killed(Actor self, AttackInfo e)
		{
			foreach (var collector in self.World.ActorsWithTrait<SupplyCollector>().Where(a => a.Trait.DeliveryBuilding == self || a.Trait.CollectionBuilding == self))
				HandleCondition(self, collector.Actor, true);
		}

		void INotifyActorDisposing.Disposing(Actor self)
		{
			foreach (var collector in self.World.ActorsWithTrait<SupplyCollector>().Where(a => a.Trait.DeliveryBuilding == self || a.Trait.CollectionBuilding == self))
				HandleCondition(self, collector.Actor, true);
		}

		protected override void TraitEnabled(Actor self)
		{
			foreach (var collector in self.World.ActorsWithTrait<SupplyCollector>().Where(a => a.Trait.DeliveryBuilding == self || a.Trait.CollectionBuilding == self))
				HandleCondition(self, collector.Actor);
		}

		protected override void TraitDisabled(Actor self)
		{
			foreach (var collector in self.World.ActorsWithTrait<SupplyCollector>().Where(a => a.Trait.DeliveryBuilding == self || a.Trait.CollectionBuilding == self))
				HandleCondition(self, collector.Actor, true);
		}
	}
}
