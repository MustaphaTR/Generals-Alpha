--[[
   Copyright 2007-2018 The OpenRA Developers (see AUTHORS)
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

ProducedUnitTypes =
{
	{ factory = GLABarracks, types = { "infantry.rebel", "infantry.rpg_trooper", "infantry.terrorist" } },
	{ factory = PRCBarracks, types = { "infantry.red_guard", "infantry.tank_hunter" } },
	{ factory = USAWarFactory, types = { "vehicle.humvee", "vehicle.crusader_tank" } },
	{ factory = GLAWarFactory, types = { "vehicle.scorpion_tank", "vehicle.quad_cannon", "vehicle.marauder_tank" } },
	{ factory = PRCWarFactory, types = { "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.dragon_tank" } },
	{ factory = USAAirfield, types = { "aircraft.raptor" } }
}

StrategyTypes = { "strategy.bombardment", "strategy.search_and_destroy", "strategy.hold_the_line" }
DroneUpgrades = { "upgrade.scout_drone", "upgrade.battle_drone" }
SCUDUpgrades = { "upgrade.toxin_missiles", "upgrade.hi_explosive_missiles" }
OverlordUpgrades = { "upgrade.overlord_gatling", "upgrade.overlord_speaker" }

TunnelTeam = { "vehicle.technical", "vehicle.technical", "vehicle.toxin_tractor", "vehicle.scorpion_tank", "infantry.rebel", "infantry.rebel" }
TopRightTeam = { "vehicle.scorpion_tank", "vehicle.scorpion_tank", "vehicle.marauder_tank", "vehicle.marauder_tank", "infantry.rpg_trooper", "infantry.rpg_trooper" }
WarFactoryTeam = { "vehicle.rocket_buggy", "vehicle.rocket_buggy", "vehicle.rocket_buggy" }
BottomLeftTeam = { "vehicle.usa_mcc", "vehicle.humvee", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender" }

BindActorTriggers = function(a)
	if a.HasProperty("DetonateAttack") then
		Trigger.OnIdle(a, function(a)
			if a.IsInWorld then
				a.DetonateAttack(USAStrategy)
			end
		end)

		Trigger.OnDamaged(a, function()
			if a.Health <= 15 then
				a.Detonate()
			end
		end)
	else
		if a.HasProperty("Hunt") then
			if a.Type == "vehicle.quad_cannon" or a.Type == "vehicle.scorpion_tank" or a.Type == "vehicle.marauder_tank" then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(USAPatriot3.Location)
					end
				end)
			elseif a.Type == "vehicle.humvee" or a.Type == "vehicle.battlemaster_tank" or a.Type == "vehicle.crusader_tank" or a.Type == "vehicle.gatling_tank" or a.Type == "vehicle.dragon_tank" then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(GLABlackMarket.Location)
					end
				end)
			elseif a.Type == "aircraft.raptor" then
				if a.IsInWorld then
					a.Attack(GLATunnelNetwork)
				end
			elseif a.Type == "infantry.red_guard" or a.Type == "infantry.tank_hunter" then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(GLATunnelNetwork.Location)
					end
				end)
			else
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(USAStrategy.Location)
					end
				end)
			end
		end
	end
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

SelectUpgrade = function(actor, upgrades)
	local upgradeType = upgrades[Utils.RandomInteger(1, #upgrades + 1)]
	actor.Produce(upgradeType)
end

SetupDefensiveUnits = function()
	Utils.Do(Map.NamedActors, function(a)
		if (a.Owner == prc or a.Owner == gla or a.Owner == usa) and a.HasProperty("AcceptsCondition") and a.AcceptsCondition("unkillable") then
			a.GrantCondition("unkillable")
			a.Stance = "Defend"
		end
	end)
end

SetupFactories = function()
	Utils.Do(ProducedUnitTypes, function(production)
		Trigger.OnProduction(production.factory, function(_, a) BindActorTriggers(a) end)
	end)
end

SendAttack = function(owner, team, waypoint, target, interval)
	Trigger.AfterDelay(interval, function()
		local actors = Reinforcements.Reinforce(owner, team, {waypoint.Location, waypoint.Location} )
		Utils.Do(actors, function(a)
			if a.HasProperty("Hunt") then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(target.Location)
					end
				end)
			else
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.Move(target.Location)
					end
				end)
			end
		end)

		SendAttack(owner, team, waypoint, target, interval)
	end)
end

DeployMe = function(unit)
	unit.GrantCondition("deployed")
end

ticks = 768
speed = 5

Tick = function()
	ticks = ticks + 1

	local t = (ticks + 45) % (360 * speed) * (math.pi / 180) / speed;
	Camera.Position = viewportOrigin + WVec.New(15360 * math.sin(t), 20480 * math.cos(t), 0)
end

WorldLoaded = function()
	usa = Player.GetPlayer("USA")
	gla = Player.GetPlayer("GLA")
	prc = Player.GetPlayer("PRC")
	viewportOrigin = Camera.Position

	SetupDefensiveUnits()
	SetupFactories()
	Utils.Do(ProducedUnitTypes, ProduceUnits)

	SelectUpgrade(USAStrategy, StrategyTypes)
	SelectUpgrade(CrusaderTank1, DroneUpgrades)
	SelectUpgrade(SCUDLauncher1, SCUDUpgrades)
	SelectUpgrade(OverlordTank1, OverlordUpgrades)

	SendAttack(usa, BottomLeftTeam, BottomLeftTeamWP, USAStrategy, DateTime.Seconds(50))
	SendAttack(gla, TopRightTeam, TopRightTeamWP, USAStrategy, DateTime.Seconds(60))
	SendAttack(gla, TunnelTeam, TunnelTeamWP, USAStrategy, DateTime.Seconds(30))
	SendAttack(gla, WarFactoryTeam, WarFactoryTeamWP, USAPatriot3, DateTime.Seconds(80))

	DeployMe(Hacker1)
	DeployMe(Hacker2)
	DeployMe(Hacker3)
	DeployMe(Hacker4)
	DeployMe(Hacker5)
	DeployMe(Hacker6)
	DeployMe(Hacker7)
	DeployMe(Hacker8)
end
