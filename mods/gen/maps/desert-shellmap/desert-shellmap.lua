--[[
   Copyright (c) The OpenRA Developers and Contributors
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
	{ factory = USAAirfield3, types = { "aircraft.comanche" } }
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

ParadropWaypoints = { Paradrop1, Paradrop2, Paradrop3, Paradrop4 }

FusionReactors = { USAReactor1, USAReactor2, USAReactor3, USAReactor4, USAReactor5, USAReactor6, USAReactor7, USAReactor8, USAReactor9, USAReactor10 }

BindActorTriggers = function(a)
	if a.Type == "infantry.terrorist" or a.Type == "vehicle.bomb_truck" then
		Trigger.OnIdle(a, function(a)
			if a.IsInWorld then
				a.AttackMove(PRCNukeSiloTarget.Location)
			end
		end)

		Trigger.OnDamaged(a, function()
			if a.Health <= 1500 then
				a.GrantCondition("triggered")
			end
		end)
	else
		if a.HasProperty("Hunt") then
			if a.Owner == PRC then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.Hunt()
					end
				end)
			else
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(PRCNukeSiloTarget.Location)
					end
				end)
			end
		else
			if a.Owner ~= PRC then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.Move(PRCNukeSiloTarget.Location)
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

	if a.Type == "vehicle.humvee" or a.Type == "vehicle.crusader_tank" or a.Type == "vehicle.tomahawk_launcher" or a.Type == "vehicle.paladin_tank" then
		SelectUpgrade(a, DroneUpgrades)
	end

	if a.Type == "vehicle.scud_launcher" then
		SelectUpgrade(a, SCUDUpgrades)
	end

	if a.Type == "vehicle.overlord_tank" then
		SelectUpgrade(a, OverlordUpgrades)
	end
end

SendChinook = function()
	Trigger.AfterDelay(DateTime.Seconds(40), function()
		local units = Reinforcements.ReinforceWithTransport(USA, "aircraft.chinook", ChinookReinforcements[Utils.RandomInteger(1, #ChinookReinforcements + 1)], ChinookPaths, { ChinookPaths[1] })[2]
		Utils.Do(units, BindActorTriggers)

		SendChinook()
	end)
end

SendBombTruck = function()
	Trigger.AfterDelay(DateTime.Seconds(65), function()
		local units = Reinforcements.Reinforce(GLA, { "vehicle.bomb_truck" }, BombTruckPaths )
		Utils.Do(units, function(unit)
			Trigger.AfterDelay(DateTime.Seconds(1), function()
				unit.DisguiseAs(BombTruckDisguises[Utils.RandomInteger(1, #BombTruckDisguises + 1)])
				SelectUpgrade(unit, BombTruckUpgrades)
			end)
		end)

		SendBombTruck()
	end)
end

SetupFactories = function()
	Utils.Do(ProducedUnitTypes, function(production)
		Trigger.OnProduction(production.factory, function(_, a) BindActorTriggers(a) end)
	end)
end

SendRaptors = function(waypoints)
	local raptorEntryPath = { waypoints[1].Location, waypoints[2].Location }
	local raptors = Reinforcements.Reinforce(USA, { "aircraft.raptor" }, raptorEntryPath, 4)
	Utils.Do(raptors, function(raptor)
		raptor.Move(waypoints[3].Location)
		raptor.Move(waypoints[4].Location)
		raptor.Destroy()
	end)

	Trigger.AfterDelay(DateTime.Seconds(40), function() SendRaptors(waypoints) end)
end

WorldLoaded = function()
	USA = Player.GetPlayer("USA")
	GLA = Player.GetPlayer("GLA")
	PRC = Player.GetPlayer("PRC")

	SetupDefensiveUnits({ USA, GLA, PRC})
	SetupFactories()
	SendChinook()
	SendBombTruck()
	Utils.Do(ProducedUnitTypes, ProduceUnits)

	SelectUpgrade(USAStrategy, StrategyTypes)
	SelectUpgrade(OverlordTank1, OverlordUpgrades)
	SelectUpgrade(ScudLauncher1, SCUDUpgrades)
	SelectUpgrade(ScudLauncher2, SCUDUpgrades)

	Utils.Do(FusionReactors, function(a)
		SelectUpgrade(a, { "upgrade.control_rods" } )
	end)

	GiveMeMines(PRCWarFactory)
	GiveMeMines(PRCPower5)
	GiveMeMines(PRCPower6)
	GiveMeMines(PRCPower7)
	GiveMeMines(PRCGatling2)
	GiveMeMines(PRCGatling3)
	GiveMeMines(PRCBunker1)

	PowerproxyPara = Actor.Create("powerproxy.paradrop", false, { Owner = USA })
	PowerproxyArty = Actor.Create("powerproxy.artillery_barrage", false, { Owner = PRC })
	Actor.Create("upgrade.countermeasures", true, { Owner = USA })

	Trigger.AfterDelay(DateTime.Seconds(30), function() SendRaptors(Raptor1Waypoints) end)
	Trigger.AfterDelay(DateTime.Seconds(30), function() SendRaptors(Raptor2Waypoints) end)

	Trigger.AfterDelay(DateTime.Minutes(4), function() SendParadrop(PowerproxyPara, DateTime.Minutes(4)) end)
	Trigger.AfterDelay(DateTime.Minutes(5), function() SendAirstrike(PowerproxyArty, ArtyBarrWaypoint, Angle.South, DateTime.Minutes(5)) end)
	SummonActor("hack.rebel_spawner.8", GLA, AmbushLocation1.Location, DateTime.Minutes(4))
end
