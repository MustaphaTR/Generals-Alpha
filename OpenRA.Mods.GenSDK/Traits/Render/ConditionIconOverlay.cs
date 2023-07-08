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
using OpenRA.Traits;

namespace OpenRA.Mods.GenSDK.Traits
{
	[Desc("Applies icon overlays on actors producible from this actor.")]
	public class ConditionIconOverlayInfo : ConditionalTraitInfo, Requires<ProductionQueueInfo>
	{
		[FieldLoader.Require]
		[Desc("Actor that this condition will apply.")]
		public readonly string Actor = null;

		[FieldLoader.Require]
		[Desc("Image used for the overlay.")]
		public readonly string Image = null;

		[SequenceReference(nameof(Image))]
		[Desc("Sequence used for the overlay (cannot be animated).")]
		public readonly string Sequence = null;

		[PaletteReference]
		[Desc("Palette to render the sprite in. Reference the world actor's PaletteFrom* traits.")]
		public readonly string Palette = "chrome";

		public override object Create(ActorInitializer init) { return new ConditionIconOverlay(init.Self, this); }
	}

	public class ConditionIconOverlay : ConditionalTrait<ConditionIconOverlayInfo>, IProductionIconOverlay
	{
		readonly Actor self;
		readonly Sprite sprite;

		public ConditionIconOverlay(Actor self, ConditionIconOverlayInfo info)
			: base(info)
		{
			this.self = self;

			var anim = new Animation(self.World, info.Image);
			anim.Play(info.Sequence);
			sprite = anim.Image;
		}

		Sprite IProductionIconOverlay.Sprite { get { return sprite; } }
		string IProductionIconOverlay.Palette { get { return Info.Palette; } }
		float2 IProductionIconOverlay.Offset(float2 iconSize)
		{
			var x = (sprite.Size.X - iconSize.X) / 2;
			var y = (sprite.Size.Y - iconSize.Y) / 2;
			return new float2(x, y);
		}

		bool IProductionIconOverlay.IsOverlayActive(ActorInfo ai, Actor producer)
		{
			if (IsTraitDisabled)
				return false;

			return ai.Name == Info.Actor && producer == self;
		}
	}
}
