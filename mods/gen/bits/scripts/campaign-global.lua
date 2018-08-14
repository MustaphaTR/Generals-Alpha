--[[
   Copyright 2007-2018 The OpenRA Developers (see AUTHORS)
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

Difficulty = Map.LobbyOption("difficulty")

IdleHunt = function(actor)
	if actor.HasProperty("Hunt") and not actor.IsDead then
		Trigger.OnIdle(actor, actor.Hunt)
	end
end

RepairBuilding = function(owner, actor, modifier)
	Trigger.OnDamaged(actor, function(building)
		if building.Owner == owner and building.Health < building.MaxHealth * modifier then
			building.StartBuildingRepairs()
		end
	end)
end

RepairBase = function(owner, baseBuildings, modifier)
	Utils.Do(baseBuildings, function(actor)
		if actor.IsDead then
			return
		end

		RepairBuilding(owner, actor, modifier)
	end)
end
