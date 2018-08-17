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

ResearchUpgrade = function(building, upgrade)
	local buildings = enemy.GetActorsByType(building)
	if #buildings > 0 then
		buildings[1].Build( { upgrade } )
	else
		Trigger.AfterDelay(DateTime.Minutes(1), function()
			ResearchUpgrade(building, upgrade)
		end)
	end
end

TrainHackers = function(owner, hacker, amount, rally_point, internet)
	local barrackes = owner.GetActorsByType("building.prc_barracks")
	if #barrackes > 0 then
		local built = barrackes[1].Build( { hacker }, function(a)
			a[1].Move(rally_point)
			if internet then
				a[1].EnterTransport(owner.GetActorsByType("building.internet_center")[1])
			else
				Trigger.OnEnteredFootprint({ rally_point }, function(enterer)
					if enterer == a[1] then
						a[1].GrantCondition("deployed")
					end
				end)
			end
		end)
		if built and amount > 1 then
			TrainHackers(owner, hacker, amount - 1, rally_point, internet)
		elseif not built then
			Trigger.AfterDelay(DateTime.Minutes(1), function()
				TrainHackers(owner, hacker, amount, rally_point, internet)
			end)
		end
	else
		Trigger.AfterDelay(DateTime.Minutes(1), function()
			TrainHackers(owner, hacker, amount, rally_point, internet)
		end)
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
