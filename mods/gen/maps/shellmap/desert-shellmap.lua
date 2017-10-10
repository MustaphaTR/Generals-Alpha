--[[
   Copyright 2007-2017 The OpenRA Developers (see AUTHORS)
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
	{ factory = GLABarracks1, types = { "infantry.rebel", "infantry.rpg_trooper", "infantry.terrorist", "infantry.angry_mob" } },
	{ factory = GLABarracks2, types = { "infantry.rebel", "infantry.rpg_trooper", "infantry.terrorist", "infantry.angry_mob" } },
	{ factory = PRCBarracks1, types = { "infantry.red_guard", "infantry.tank_hunter" } },
	{ factory = PRCBarracks2, types = { "infantry.red_guard", "infantry.tank_hunter" } },
	{ factory = USAWarFactory, types = { "vehicle.humvee", "vehicle.crusader_tank", "vehicle.tomahawk_launcher", "vehicle.paladin_tank" } },
	{ factory = GLAWarFactory, types = { "vehicle.technical", "vehicle.scorpion_tank", "vehicle.quad_cannon", "vehicle.rocket_buggy", "vehicle.toxin_tractor", "vehicle.marauder_tank", "vehicle.scud_launcher" } },
	{ factory = PRCWarFactory, types = { "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.dragon_tank", "vehicle.inferno_cannon", "vehicle.overlord_tank" } },
	{ factory = USAAirfield1, types = { "aircraft.comanche" } },
	{ factory = USAAirfield2, types = { "aircraft.comanche" } },
	{ factory = USAAirfield3, types = { "aircraft.comanche" } },
}

StrategyTypes =
{
	{ factory = USACommand, types = { "strategy.bombardment", "strategy.search_and_destroy", "strategy.hold_the_line" } },
	{ factory = GLACommand, types = { "strategy.bio_bombs", "strategy.hi_explosive_bombs", "strategy.disguise" } },
	{ factory = PRCCommand, types = { "strategy.overlord_gatling", "strategy.overlord_bunker", "strategy.overlord_speaker" } }
}

Raptor1Waypoints = { Raptor11, Raptor12, Raptor13, Raptor14 }
Raptor2Waypoints = { Raptor21, Raptor22, Raptor23, Raptor24 }

ChinookReinforcements =
{
	{ "vehicle.humvee", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.ranger" },
	{ "vehicle.crusader_tank", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" },
	{ "vehicle.ambulance", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.ranger" },
	{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger" },
	{ "infantry.ranger", "infantry.missile_defender", "infantry.ranger", "infantry.missile_defender", "infantry.ranger", "infantry.missile_defender", "infantry.ranger", "infantry.missile_defender" },
	{ "vehicle.crusader_tank", "vehicle.crusader_tank", "infantry.ranger", "infantry.missile_defender" },
	{ "vehicle.paladin_tank", "vehicle.crusader_tank", "infantry.ranger", "infantry.missile_defender" },
	{ "vehicle.humvee", "vehicle.humvee", "infantry.ranger", "infantry.ranger" }
}
ChinookPaths = { ChinookEntry.Location, ChinookRally.Location }

BombTruckDisguises = { CrusaderTank1, Ambulance1, TomahawkLauncher1, PaladinTank1, Humvee1, USAMCC1 }
BombTruckPaths = { BombTruckEntry.Location, BombTruckRally.Location }

BindActorTriggers = function(a)
	if a.HasProperty("Hunt") then
		if a.Owner == prc then
			Trigger.OnIdle(a, function(a)
				if a.IsInWorld then
					a.Hunt()
				end
			end)
		else
			Trigger.OnIdle(a, function(a)
				if a.IsInWorld then
					a.AttackMove(NukeSilo.Location)
				end
			end)
		end
	else
		if a.Owner ~= prc then
			Trigger.OnIdle(a, function(a)
				if a.IsInWorld then
					a.Move(NukeSilo.Location)
				end
			end)
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

SendChinook = function()
	Trigger.AfterDelay(DateTime.Seconds(40), function()
		local units = Reinforcements.ReinforceWithTransport(usa, "aircraft.chinook", ChinookReinforcements[Utils.RandomInteger(1, #ChinookReinforcements + 1)], ChinookPaths, { ChinookPaths[1] })[2]
		Utils.Do(units, BindActorTriggers)

		SendChinook()
	end)
end

SendBombTruck = function()
	Trigger.AfterDelay(DateTime.Seconds(65), function()
		local units = Reinforcements.Reinforce(gla, { "vehicle.bomb_truck" }, BombTruckPaths )
		Utils.Do(units, function(unit)
			Trigger.AfterDelay(DateTime.Seconds(1), function()
				unit.DisguiseAs(BombTruckDisguises[Utils.RandomInteger(1, #BombTruckDisguises + 1)])
			end)
		end)

		SendBombTruck()
	end)
end

SelectStrategy = function(t)
	local factory = t.factory
	if not factory.IsDead then
		local strategyType = t.types[Utils.RandomInteger(1, #t.types + 1)]
		factory.Produce(strategyType)
	end
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

SendRaptors = function(waypoints)
	local raptorEntryPath = { waypoints[1].Location, waypoints[2].Location }
	local raptors = Reinforcements.Reinforce(usa, { "aircraft.raptor" }, raptorEntryPath, 4)
	Utils.Do(raptors, function(raptor)
		raptor.Move(waypoints[3].Location)
		raptor.Move(waypoints[4].Location)
		raptor.Destroy()
	end)

	Trigger.AfterDelay(DateTime.Seconds(40), function() SendRaptors(waypoints) end)
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
	SendChinook()
	SendBombTruck()
	Utils.Do(ProducedUnitTypes, ProduceUnits)
	Utils.Do(StrategyTypes, SelectStrategy)

	DeployMe(Hacker1)
	DeployMe(Hacker2)
	DeployMe(Hacker3)
	DeployMe(Hacker4)
	DeployMe(Hacker5)
	DeployMe(Hacker6)

	Trigger.AfterDelay(DateTime.Seconds(25), function() SendRaptors(Raptor1Waypoints) end)
	Trigger.AfterDelay(DateTime.Seconds(25), function() SendRaptors(Raptor2Waypoints) end)

	SummonActor("hack.rebel_spawner.8", gla, AmbushLocation1.Location, DateTime.Minutes(4))
	SummonActor("hack.artillery_barrager.3", prc, ArtyBarrWaypoint.Location, DateTime.Minutes(5))
end
