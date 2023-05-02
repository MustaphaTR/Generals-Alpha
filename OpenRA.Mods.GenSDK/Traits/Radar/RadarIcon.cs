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

using System.Collections.Generic;
using System.Linq;
using OpenRA.Mods.Common.Traits;
using OpenRA.Primitives;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits.Radar
{
	public class RadarIconInfo : ConditionalTraitInfo
	{
		public readonly HashSet<CVec> Locations = new HashSet<CVec>
		{
			new CVec(-1, 0),
			new CVec(-2, 0),
			new CVec(1, 0),
			new CVec(2, 0),
			new CVec(0, -1),
			new CVec(0, -2),
			new CVec(0, 1),
			new CVec(0, 2)
		};

		public readonly Color Color = Color.White;

		[Desc("PlayerRelationships who can view this actor's icon on radar.")]
		public readonly PlayerRelationship ValidRelationships = PlayerRelationship.Ally;

		public override object Create(ActorInitializer init) { return new RadarIcon(this); }
	}

	public class RadarIcon : ConditionalTrait<RadarIconInfo>, IRadarSignature
	{
		IRadarColorModifier modifier;

		public RadarIcon(RadarIconInfo info)
			: base(info) { }

		protected override void Created(Actor self)
		{
			base.Created(self);
			modifier = self.TraitsImplementing<IRadarColorModifier>().FirstOrDefault();
		}

		public void PopulateRadarSignatureCells(Actor self, List<(CPos, Color)> destinationBuffer)
		{
			var viewer = self.World.RenderPlayer ?? self.World.LocalPlayer;
			if (IsTraitDisabled || (viewer != null && !Info.ValidRelationships.HasStance(self.Owner.RelationshipWith(viewer))))
				return;

			var color = Info.Color;
			if (modifier != null)
				color = modifier.RadarColorOverride(self, color);

			var cells = Info.Locations.Select(loc => self.Location + loc);
			foreach (var cell in cells)
				destinationBuffer.Add((cell, color));
		}
	}
}
