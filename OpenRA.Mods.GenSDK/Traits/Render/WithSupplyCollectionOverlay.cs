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

using OpenRA.Graphics;
using OpenRA.Mods.Common.Traits;
using OpenRA.Mods.Common.Traits.Render;
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	public class WithSupplyCollectionOverlayInfo : TraitInfo, Requires<WithSpriteBodyInfo>
	{
		[SequenceReference]
		[Desc("Sequence name to use")]
		public readonly string Sequence = "collect";

		[Desc("Position relative to body")]
		public readonly WVec LocalOffset = WVec.Zero;

		[Desc("Wait this much extra on the delivery position for overlay to play.",
		"I couldn't manage to code something automatic. But this customisation also allow better stuff.",
		"ex. Chinnok giving cash right after crane is at the ground and doesn't wait it to go back up.")]
		public readonly int WaitDelay = 25;

		[PaletteReference]
		public readonly string Palette = "effect";

		public override object Create(ActorInitializer init) { return new WithSupplyCollectionOverlay(init.Self, this); }
	}

	public class WithSupplyCollectionOverlay
	{
		public readonly WithSupplyCollectionOverlayInfo Info;
		public readonly Animation Anim;
		public bool Visible;

		public WithSupplyCollectionOverlay(Actor self, WithSupplyCollectionOverlayInfo info)
		{
			Info = info;
			var rs = self.Trait<RenderSprites>();
			var body = self.Trait<BodyOrientation>();

			Anim = new Animation(self.World, rs.GetImage(self), RenderSprites.MakeFacingFunc(self)) { IsDecoration = true };
			Anim.Play(info.Sequence);
			rs.Add(new AnimationWithOffset(Anim,
				() => body.LocalToWorld(info.LocalOffset.Rotate(body.QuantizeOrientation(self.Orientation))),
				() => !Visible,
				p => ZOffsetFromCenter(self, p, 0)), info.Palette);
		}

		public static int ZOffsetFromCenter(Actor self, WPos pos, int offset)
		{
			var delta = self.CenterPosition - pos;
			return delta.Y + delta.Z + offset;
		}
	}
}
