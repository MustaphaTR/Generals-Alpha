--[[
   Copyright (c) The OpenRA Developers and Contributors
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

StrategyTypes = { "strategy.bombardment", "strategy.search_and_destroy", "strategy.hold_the_line" }
DroneUpgrades = { "upgrade.scout_drone", "upgrade.battle_drone", "upgrade.hellfire_drone" }
BombTruckUpgrades = { "upgrade.bio_bombs", "upgrade.hi_explosive_bombs" }
SCUDUpgrades = { "upgrade.toxin_missiles", "upgrade.hi_explosive_missiles" }
OverlordUpgrades = { "upgrade.overlord_gatling", "upgrade.overlord_speaker" }

IdleHunt = function(actor)
	if actor.HasProperty("Hunt") and not actor.IsDead then
		Trigger.OnIdle(actor, actor.Hunt)
	end
end

SetupDefensiveUnits = function(players)
	Utils.Do(Map.NamedActors, function(a)
		if (Utils.Any(players, function(p) return p == a.Owner end)) and a.HasProperty("AcceptsCondition") and a.AcceptsCondition("unkillable") then
			a.GrantCondition("unkillable")
			a.Stance = "Defend"
		end
	end)
end

ProduceUnits = function(t)
	local factory = t.factory
	if not factory.IsDead then
		local unitType = t.types[Utils.RandomInteger(1, #t.types + 1)]
		factory.Wait(Actor.BuildTime(unitType))
		factory.Produce(unitType)
		factory.CallFunc(function() ProduceUnits(t) end)
	end
end

SendAirstrike = function(proxy, target, direction, timer)
	proxy.TargetAirstrike(target.CenterPosition, direction)

	Trigger.AfterDelay(timer, function() SendAirstrike(proxy, target, direction, timer) end)
end

SendParadrop = function(proxy, timer)
	local lz = Utils.Random(ParadropWaypoints)
	local units = proxy.TargetParatroopers(lz.CenterPosition)

	Utils.Do(units, function(a)
		BindActorTriggers(a)
	end)

	Trigger.AfterDelay(timer, function() SendParadrop(proxy, timer) end)
end

SummonActor = function(actor, owner, location, date_time)
	Trigger.AfterDelay(date_time, function()
		IdleHunt(Actor.Create(actor, true, { Owner = owner, Facing = Angle.North, Location = location }))

		SummonActor(actor, owner, location, date_time)
	end)
end

SelectUpgrade = function(actor, upgrades)
	local upgradeType = upgrades[Utils.RandomInteger(1, #upgrades + 1)]
	actor.Produce(upgradeType)
end

GiveMeMines = function(unit)
	unit.GrantCondition("land_mines")
end
