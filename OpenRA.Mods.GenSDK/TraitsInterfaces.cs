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

namespace OpenRA.Mods.GenSDK.Traits
{
	public interface IResourceExchange
	{
		void GiveResource(int amount, string harvester);
		bool CanGiveResource(int amount);
	}

	public interface INotifySupplyCollectorAssigned
	{
		void AssignedToSupplyCenter(Actor collector, Actor center);
		void AssignedToSupplyDock(Actor collector, Actor dock);
	}
}
