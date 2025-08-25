#region Copyright & License Information
/*
 * Copyright (c) The OpenHV Developers (see https://github.com/OpenHV/OpenHV)
 * This file is part of OpenHV, which is free software. It is made
 * available to you under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version. For more
 * information, see COPYING.
 */
#endregion

using System.Collections.Generic;
using System.Linq;
using OpenRA.Mods.Common;
using OpenRA.Mods.Common.Traits;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	[Desc("Manages the initial base and build dozer on request.")]
	public class InitialBaseAndWorkerBotModuleInfo : ConditionalTraitInfo
	{
		[Desc("Actor types that are dozers.")]
		public readonly HashSet<string> DozerTypes = [];

		[Desc("Actor types that are able to produce dozers.")]
		public readonly int MinimumDozerCount = 2;

		[Desc("Produce dozers when game start.")]
		public readonly bool ProduceDozerAtStart = false;

		[Desc("Actor types that are able to produce dozers.")]
		public readonly HashSet<string> CommandCenterTypes = [];

		[Desc("Delay (in ticks) between looking for dozers.")]
		public readonly int ScanInterval = 179;

		public override object Create(ActorInitializer init) { return new InitialBaseAndWorkerBotModule(init.Self, this); }
	}

	public class InitialBaseAndWorkerBotModule : ConditionalTrait<InitialBaseAndWorkerBotModuleInfo>, IBotTick, IBotPositionsUpdated, INotifyActorDisposing, IGameSaveTraitData
	{
		readonly World world;
		readonly Player player;

		IBotPositionsUpdated[] notifyPositionsUpdated;
		IBotRequestUnitProduction[] requestUnitProduction;

		CPos initialBaseCenter;
		bool initialized;
		int scanInterval;

		readonly ActorIndex.OwnerAndNamesAndTrait<MobileInfo> dozers;
		readonly ActorIndex.OwnerAndNamesAndTrait<BuildingInfo> commandCenters;

		public InitialBaseAndWorkerBotModule(Actor self, InitialBaseAndWorkerBotModuleInfo info)
			: base(info)
		{
			world = self.World;
			player = self.Owner;

			dozers = new ActorIndex.OwnerAndNamesAndTrait<MobileInfo>(world, Info.DozerTypes, player);
			commandCenters = new ActorIndex.OwnerAndNamesAndTrait<BuildingInfo>(world, Info.CommandCenterTypes, player);
		}

		protected override void Created(Actor self)
		{
			notifyPositionsUpdated = self.Owner.PlayerActor.TraitsImplementing<IBotPositionsUpdated>().ToArray();
			requestUnitProduction = self.Owner.PlayerActor.TraitsImplementing<IBotRequestUnitProduction>().ToArray();
		}

		protected override void TraitEnabled(Actor self)
		{
			// Avoid all AIs reevaluating assignments on the same tick, randomize their initial evaluation delay.
			scanInterval = world.LocalRandom.Next(0, Info.ScanInterval);
		}

		void IBotTick.BotTick(IBot bot)
		{
			if (!initialized)
			{
				var baseBuildings = world.ActorsHavingTrait<Building>().Where(a => a.Owner == player && Info.CommandCenterTypes.Contains(a.Info.Name)).ToList();
				foreach (var baseBuilding in baseBuildings)
					SetCenter(baseBuilding.Location);

				// Build a new Dozer
				if (ShouldBuildDozer())
					BuildDozer(bot);

				initialized = true;
			}

			if (--scanInterval <= 0)
			{
				scanInterval = Info.ScanInterval;

				// Build a new Dozer
				if (ShouldBuildDozer())
					BuildDozer(bot);
			}
		}

		void SetCenter(CPos location)
		{
			foreach (var notify in notifyPositionsUpdated)
			{
				notify.UpdatedBaseCenter(location);
				notify.UpdatedDefenseCenter(location);
			}
		}

		void BuildDozer(IBot bot)
		{
			var unitBuilder = requestUnitProduction.FirstOrDefault(Exts.IsTraitEnabled);
			if (unitBuilder != null)
			{
				var dozerType = Info.DozerTypes.Random(world.LocalRandom);
				if (unitBuilder.RequestedProductionCount(bot, dozerType) == 0)
					unitBuilder.RequestUnitProduction(bot, dozerType);
			}
		}

		bool ShouldBuildDozer()
		{
			// Only build Dozer if we don't already have one in the field.
			var allowedToBuildDozer = AIUtils.CountActorByCommonName(dozers) < Info.MinimumDozerCount;
			if (!allowedToBuildDozer)
				return false;

			// Build Dozer if we don't have the desired number of them, unless we have no factory (can't build it).
			return AIUtils.CountActorByCommonName(commandCenters) > 0;
		}

		void IBotPositionsUpdated.UpdatedBaseCenter(CPos newLocation)
		{
			initialBaseCenter = newLocation;
		}

		void IBotPositionsUpdated.UpdatedDefenseCenter(CPos newLocation) { }

		List<MiniYamlNode> IGameSaveTraitData.IssueTraitData(Actor self)
		{
			if (IsTraitDisabled)
				return null;

			return
			[
				new("InitialBaseCenter", FieldSaver.FormatValue(initialBaseCenter))
			];
		}

		void IGameSaveTraitData.ResolveTraitData(Actor self, MiniYaml data)
		{
			if (self.World.IsReplay)
				return;

			var nodes = data.ToDictionary();

			if (nodes.TryGetValue("InitialBaseCenter", out var initialBaseCenterNode))
				initialBaseCenter = FieldLoader.GetValue<CPos>("InitialBaseCenter", initialBaseCenterNode.Value);
		}

		void INotifyActorDisposing.Disposing(Actor self)
		{
			dozers.Dispose();
			commandCenters.Dispose();
		}
	}
}
