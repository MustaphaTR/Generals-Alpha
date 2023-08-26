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
using System.Linq;
using OpenRA.GameRules;
using OpenRA.Mods.AS.Warheads;
using OpenRA.Mods.Common;
using OpenRA.Mods.Common.Traits;
using OpenRA.Mods.Common.Effects;
using OpenRA.Mods.GenSDK.Traits;
using OpenRA.Primitives;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Warheads
{
	[Desc("Steal cash from the owner of the target actor. Requires CashHackable trait on the target actor.")]
	public class CashHackWarhead : WarheadAS
	{
		[Desc("Range of targets to have cash stolen from.")]
		public readonly WDist Range = new(64);

		[Desc("Types of cash hacking to steal from.")]
		public readonly string[] Types = { "Cash-Hack" };

		[Desc("Percentage of the victim's resources that will be stolen.")]
		public readonly int Percentage = 100;

		[Desc("Amount of guaranteed funds to claim when the victim does not have enough resources.")]
		public readonly int Minimum = 0;

		[Desc("Maximum amount of funds which will be stolen.")]
		public readonly int Maximum = 1000;

		public override void DoImpact(in Target target, WarheadArgs args)
		{
			var firedBy = args.SourceActor;
			if (!target.IsValidFor(firedBy))
				return;

			var pos = target.CenterPosition;

			if (!IsValidImpact(pos, firedBy))
				return;

			var ownResources = firedBy.Owner.PlayerActor.Trait<PlayerResources>();
			var availableActors = firedBy.World.FindActorsOnCircle(pos, Range);
			foreach (var a in availableActors)
			{
				if (!IsValidAgainst(a, firedBy))
					continue;

				var activeShapes = a.TraitsImplementing<HitShape>().Where(Exts.IsTraitEnabled);
				if (!activeShapes.Any())
					continue;

				var distance = activeShapes.Min(t => t.DistanceFromEdge(a, pos));

				if (distance > Range)
					continue;

				if (a.IsDead)
					continue;

				firedBy.World.AddFrameEndTask(w =>
				{
					if (a.IsDead)
						return;

					var enemyResources = a.Owner.PlayerActor.Trait<PlayerResources>();

					var toTake = Math.Min(Maximum, (enemyResources.Cash + enemyResources.Resources) * Percentage / 100);
					var toGive = Math.Max(toTake, Minimum);

					enemyResources.TakeCash(toTake);
					ownResources.GiveCash(toGive);

					w.Add(new FloatingText(a.CenterPosition, firedBy.Owner.Color, FloatingText.FormatCashTick(toGive), 30));
				});
			}
		}

		public override bool IsValidAgainst(Actor victim, Actor firedBy)
		{
			var cashHackable = victim.Info.TraitInfos<CashHackableInfo>()
				.FirstOrDefault(c => c.ValidTypes.Overlaps(Types));

			if (cashHackable == null || victim.Owner.IsAlliedWith(firedBy.Owner))
				return false;

			return base.IsValidAgainst(victim, firedBy);
		}
	}
}
