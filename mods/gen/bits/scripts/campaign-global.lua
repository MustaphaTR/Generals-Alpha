--[[
   Copyright (c) The OpenRA Developers and Contributors
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

TrainPatrolDefense = function(owner, units, producer, path, wait)
	local producers = owner.GetActorsByType(producer)
	if #producers > 0 then
		local built = Utils.Random(producers).Build(units, function(a)
			Trigger.AfterDelay(DateTime.Seconds(1), function()
				Utils.Do(a, function(unit)
					unit.Patrol(path, true, wait)
				end)

				Trigger.OnAllKilled(a, function()
					TrainPatrolDefense(owner, units, producer, path, wait)
				end)
			end)
		end)
		if not built then
			Trigger.AfterDelay(DateTime.Seconds(15), function()
				TrainPatrolDefense(owner, units, producer, path, wait)
			end)
		end
	else
		Trigger.AfterDelay(DateTime.Seconds(15), function()
			TrainPatrolDefense(owner, units, producer, path, wait)
		end)
	end
end

TrainStaticDefense = function(owner, units, producer, rally_point)
	local producers = owner.GetActorsByType(producer)
	if #producers > 0 then
		local built = Utils.Random(producers).Build(units, function(a)
			Trigger.AfterDelay(DateTime.Seconds(1), function()
				Utils.Do(a, function(unit)
					unit.AttackMove(rally_point)
				end)

				Trigger.OnAllKilled(a, function()
					TrainStaticDefense(owner, units, producer, rally_point)
				end)
			end)
		end)
		if not built then
			Trigger.AfterDelay(DateTime.Seconds(15), function()
				TrainStaticDefense(owner, units, producer, rally_point)
			end)
		end
	else
		Trigger.AfterDelay(DateTime.Seconds(15), function()
			TrainStaticDefense(owner, units, producer, rally_point)
		end)
	end
end

CaptureTechBuildings = function(buildings, factory, infantry)
	local built = Utils.Random(Enemy.GetActorsByType(factory)).Build({ infantry }, function(a)
		Utils.Do(Utils.Where(buildings, function(b) return not b.IsDead end), function(tech)
			a[1].Capture(tech)
		end)
	end)
	if not built then
		Trigger.AfterDelay(DateTime.Seconds(15), function()
			CaptureTechBuildings(buildings, factory, infantry)
		end)
	end
end

TrainHackers = function(owner, hacker, amount, rally_point, internet)
	local barrackses = owner.GetActorsByType("building.prc_barracks")
	if #barrackses > 0 then
		local built = barrackses[1].Build( { hacker }, function(a)
			Trigger.AfterDelay(DateTime.Seconds(1), function()
				a[1].Move(rally_point)
				if internet then
					a[1].EnterTransport(owner.GetActorsByType("building.internet_center")[1])
				else
					Trigger.OnEnteredFootprint({ rally_point }, function(enterer)
						if enterer == a[1] then
							a[1].SwitchToDeploy()
						end
					end)
				end
			end)
			Trigger.OnKilled(a[1], function()
				TrainHackers(owner, hacker, 1, rally_point, internet)
			end)
		end)
		if built and amount > 1 then
			TrainHackers(owner, hacker, amount - 1, rally_point, internet)
		elseif not built then
			Trigger.AfterDelay(DateTime.Seconds(15), function()
				TrainHackers(owner, hacker, amount, rally_point, internet)
			end)
		end
	else
		Trigger.AfterDelay(DateTime.Seconds(15), function()
			TrainHackers(owner, hacker, amount, rally_point, internet)
		end)
	end
end

TrainGarrisoners = function(owner, units, producer, garrisonables)
	local producers = owner.GetActorsByType(producer)
	if #producers > 0 then
		local built = Utils.Random(producers).Build(units, function(a)
			Trigger.AfterDelay(DateTime.Seconds(1), function()
				local garrisonable = Utils.Random(garrisonables)
				Utils.Do(a, function(unit)
					unit.AttackMove(garrisonable.Location)
					unit.EnterGarrisonable(garrisonable)
				end)
			end)
		end)
		if not built then
			Trigger.AfterDelay(DateTime.Seconds(15), function()
				TrainGarrisoners(owner, units, producer, garrisonables)
			end)
		end
	else
		Trigger.AfterDelay(DateTime.Seconds(15), function()
			TrainGarrisoners(owner, units, producer, garrisonables)
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

AttackAircraftTargets = { }
--- Order an aircraft to seek and attack an enemy player's units whenever idle.
--- Each target is focused until it can no longer be attacked.
---@param aircraft actor
---@param enemyPlayer player
InitializeAttackAircraft = function(aircraft, enemyPlayer)
	Trigger.OnIdle(aircraft, function()
		local actorId = tostring(aircraft)
		local target = AttackAircraftTargets[actorId]

		if not target or not target.IsInWorld then
			target = ChooseRandomTarget(aircraft, enemyPlayer)
		end

		if target then
			AttackAircraftTargets[actorId] = target
			aircraft.Attack(target)
		else
			AttackAircraftTargets[actorId] = nil
			aircraft.ReturnToBase()
		end
	end)
end

--- Return a random enemy target for an actor.
---@param unit actor Actor to be given a target.
---@param enemyPlayer player Player to be targeted.
---@return actor|nil
ChooseRandomTarget = function(unit, enemyPlayer)
	local target = nil
	local enemies = Utils.Where(enemyPlayer.GetActors(), function(self)
		return self.HasProperty("Health") and unit.CanTarget(self) and not Utils.Any({ "sbag", "fenc", "brik", "cycl", "barb" }, function(type) return self.Type == type end)
	end)
	if #enemies > 0 then
		target = Utils.Random(enemies)
	end
	return target
end

--- Used for debugging purposes.
SpamPlayerXPInChat = function(player)
	Trigger.AfterDelay(DateTime.Seconds(5), function ()
		if Levels[player.InternalName] < 4 then
			Media.DisplayMessage("Current Rank: " .. Ranks[Levels[player.InternalName] + 1] .. "\nGeneral's Points: " .. Points[player.InternalName] .. "\nProgress to Next Rank: " .. player.Experience - RankXPs[Levels[player.InternalName] + 1] .. "/" .. RankXPs[Levels[player.InternalName] + 2] - RankXPs[Levels[player.InternalName] + 1] .. "", "Debug", player.Color)
		else 
			Media.DisplayMessage("Current Rank: " .. Ranks[Levels[player.InternalName] + 1] .. "\nGeneral's Points: " .. Points[player.InternalName] .. "", "Debug", player.Color)
		end
		SpamPlayerXPInChat()
	end)
end
