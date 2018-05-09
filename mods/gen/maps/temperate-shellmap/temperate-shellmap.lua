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
	{ factory = USABarracks1, types = { "infantry.ranger", "infantry.missile_defender", "infantry.pathfinder" } },
	{ factory = USABarracks2, types = { "infantry.ranger", "infantry.missile_defender", "infantry.pathfinder" } },
	{ factory = USABarracks3, types = { "infantry.conscript", "infantry.grenadier", "infantry.flamethrower" } },
	{ factory = GLABarracks, types = { "infantry.rebel", "infantry.rpg_trooper", "infantry.terrorist", "infantry.angry_mob" } },
	{ factory = PRCBarracks, types = { "infantry.red_guard", "infantry.tank_hunter" } },
	{ factory = GLAWarFactory, types = { "vehicle.technical", "vehicle.scorpion_tank", "vehicle.quad_cannon", "vehicle.rocket_buggy", "vehicle.toxin_tractor", "vehicle.marauder_tank", "vehicle.scud_launcher" } },
	{ factory = PRCWarFactory, types = { "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.dragon_tank", "vehicle.inferno_cannon", "vehicle.overlord_tank" } },
	{ factory = USAAirfield1, types = { "aircraft.comanche" } },
	{ factory = USAAirfield2, types = { "aircraft.comanche" } },
	{ factory = USAShipyard, types = { "vessel.gunboat", "vessel.destroyer" } },
	{ factory = GLAShipyard, types = { "vessel.gunboat", "vessel.gunboat", "vessel.destroyer" } },
	{ factory = PRCShipyard, types = { "vessel.gunboat", "vessel.destroyer" } }
}

MiG1Waypoints = { MiG11, MiG12, MiG13 }
MiG2Waypoints = { MiG21, MiG22, MiG23 }

StrategyTypes = { "strategy.bombardment", "strategy.search_and_destroy", "strategy.hold_the_line" }
DroneUpgrades = { "upgrade.scout_drone", "upgrade.battle_drone" }
SCUDUpgrades = { "upgrade.toxin_missiles", "upgrade.hi_explosive_missiles" }
OverlordUpgrades = { "upgrade.overlord_gatling", "upgrade.overlord_speaker" }

ParadropWaypoints = { Paradrop1, Paradrop2, Paradrop3 }

BindActorTriggers = function(a)
	if a.HasProperty("DetonateAttack") then
		Trigger.OnIdle(a, function(a)
			if a.IsInWorld then
				a.DetonateAttack(USASupplyDrop2)
			end
		end)

		Trigger.OnDamaged(a, function()
			if a.Health <= 15 then
				a.Detonate()
			end
		end)
	else
		if a.HasProperty("Hunt") then
			if a.Owner == gla then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(USASupplyDrop2.Location)
					end
				end)
			else
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(GLACommand.Location)
					end
				end)
			end
		else
			if a.Owner == gla then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.Move(USASupplyDrop2.Location)
					end
				end)
			else
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.Move(GLACommand.Location)
					end
				end)
			end
		end
	end

	if a.HasProperty("HasPassengers") then
		Trigger.OnDamaged(a, function()
			if a.HasPassengers then
				a.Stop()
				a.UnloadPassengers()
			end
		end)
	end

	if a.Type == "vehicle.scud_launcher" then
		SelectUpgrade(a, SCUDUpgrades)
	end

	if a.Type == "vehicle.overlord_tank" then
		SelectUpgrade(a, OverlordUpgrades)
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

SendMiGs = function(waypoints)
	local migEntryPath = { waypoints[1].Location, waypoints[2].Location }
	local migs = Reinforcements.Reinforce(prc, { "aircraft.mig" }, migEntryPath, 4)
	Utils.Do(migs, function(mig)
		mig.Move(waypoints[2].Location)
		mig.Move(waypoints[3].Location)
		mig.Destroy()
	end)

	Trigger.AfterDelay(DateTime.Seconds(40), function() SendMiGs(waypoints) end)
end

SendA10s = function()
	powerproxyA10.SendAirstrike(A10Waypoint.CenterPosition)

	Trigger.AfterDelay(DateTime.Minutes(4), SendParadrop)
end

SendParadrop = function()
	local lz = Utils.Random(ParadropWaypoints)
	local units = powerproxyPara.SendParatroopers(lz.CenterPosition)

	Utils.Do(units, function(a)
		BindActorTriggers(a)
	end)

	Trigger.AfterDelay(DateTime.Minutes(4), SendParadrop)
end

SummonActor = function(actor, owner, location, date_time)
	Trigger.AfterDelay(date_time, function()
		local a = Actor.Create(actor, true, { Owner = owner, Facing = 0, Location = location})
		if a.HasProperty("Hunt") then
			Trigger.OnIdle(a, function(a)
				if a.IsInWorld then
					a.Hunt()
				end
			end)
		end
		
		SummonActor(actor, owner, location, date_time)
	end)
end

DeployMe = function(unit)
	unit.GrantCondition("deployed")
end

GiveMeMines = function(unit)
	unit.GrantCondition("land_mines")
end

ticks = 0
speed = 5

Tick = function()
	ticks = ticks + 1

	local t = (ticks + 45) % (360 * speed) * (math.pi / 180) / speed;
	Camera.Position = viewportOrigin + WVec.New(19200 * math.sin(t), 20480 * math.cos(t), 0)
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
	SelectUpgrade(PaladinTank1, DroneUpgrades)
	SelectUpgrade(ScudLauncher1, SCUDUpgrades)

	DeployMe(Hacker1)
	DeployMe(Hacker2)
	DeployMe(Hacker3)
	DeployMe(Hacker4)
	DeployMe(Hacker5)
	DeployMe(Hacker6)

	GiveMeMines(PRCPower1)
	GiveMeMines(PRCPower2)
	GiveMeMines(PRCPower3)
	GiveMeMines(PRCPower4)
	GiveMeMines(PRCPropaganda)
	GiveMeMines(PRCBunker)

	USAShipyard.RallyPoint = USAShipyardRally.Location
	GLAShipyard.RallyPoint = GLAShipyardRally.Location
	PRCShipyard.RallyPoint = PRCShipyardRally.Location

	powerproxyPara = Actor.Create("powerproxy.paradrop", false, { Owner = usa })
	powerproxyA10 = Actor.Create("powerproxy.a10", false, { Owner = usa })

	Trigger.AfterDelay(DateTime.Seconds(40), function() SendMiGs(MiG1Waypoints) end)
	Trigger.AfterDelay(DateTime.Seconds(40), function() SendMiGs(MiG2Waypoints) end)

	Trigger.AfterDelay(DateTime.Minutes(4) + DateTime.Seconds(15), function() SendParadrop() end)
	Trigger.AfterDelay(DateTime.Minutes(4) + DateTime.Seconds(25), function() SendA10s() end)
	SummonActor("hack.rebel_spawner.8", gla, AmbushLocation1.Location, DateTime.Minutes(4))
	SummonActor("hack.artillery_barrager.3", prc, ArtyBarrWaypoint.Location, DateTime.Minutes(5))
end
