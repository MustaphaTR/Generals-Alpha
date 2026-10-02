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

ParadropWaypoints = { Paradrop1, Paradrop2, Paradrop3 }

FusionReactors = { USAReactor1, USAReactor2, USAReactor3, USAReactor4, USAReactor5, USAReactor6 }

BindActorTriggers = function(a)
	if a.Type == "infantry.terrorist" or a.Type == "vehicle.bomb_truck" then
		Trigger.OnIdle(a, function(a)
			if a.IsInWorld then
				a.AttackMove(USADropZoneTarget.Location)
			end
		end)

		Trigger.OnDamaged(a, function()
			if a.Health <= 1500 then
				a.GrantCondition("triggered")
			end
		end)
	else
		if a.HasProperty("Hunt") then
			if a.Owner == GLA then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(USADropZoneTarget.Location)
					end
				end)
			else
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.AttackMove(GLACommandTarget.Location)
					end
				end)
			end
		else
			if a.Owner == GLA then
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.Move(USADropZoneTarget.Location)
					end
				end)
			else
				Trigger.OnIdle(a, function(a)
					if a.IsInWorld then
						a.Move(GLACommandTarget.Location)
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

SetupFactories = function()
	Utils.Do(ProducedUnitTypes, function(production)
		Trigger.OnProduction(production.factory, function(_, a) BindActorTriggers(a) end)
	end)
end

SendMiGs = function(waypoints)
	local migEntryPath = { waypoints[1].Location, waypoints[2].Location }
	local migs = Reinforcements.Reinforce(PRC, { "aircraft.mig" }, migEntryPath, 4)
	Utils.Do(migs, function(mig)
		mig.Move(waypoints[2].Location)
		mig.Move(waypoints[3].Location)
		mig.Destroy()
	end)

	Trigger.AfterDelay(DateTime.Seconds(40), function() SendMiGs(waypoints) end)
end

WorldLoaded = function()
	USA = Player.GetPlayer("USA")
	GLA = Player.GetPlayer("GLA")
	PRC = Player.GetPlayer("PRC")

	SetupDefensiveUnits({ USA, GLA, PRC})
	SetupFactories()
	Utils.Do(ProducedUnitTypes, ProduceUnits)

	SelectUpgrade(USAStrategy, StrategyTypes)
	SelectUpgrade(PaladinTank1, DroneUpgrades)
	SelectUpgrade(ScudLauncher1, SCUDUpgrades)

	Utils.Do(FusionReactors, function(a)
		SelectUpgrade(a, { "upgrade.control_rods" } )
	end)

	GiveMeMines(PRCPower1)
	GiveMeMines(PRCPower2)
	GiveMeMines(PRCPower3)
	GiveMeMines(PRCPower4)
	GiveMeMines(PRCPropaganda)
	GiveMeMines(PRCBunker)

	USAShipyard.RallyPoint = USAShipyardRally.Location
	GLAShipyard.RallyPoint = GLAShipyardRally.Location
	PRCShipyard.RallyPoint = PRCShipyardRally.Location

	PowerproxyPara = Actor.Create("powerproxy.paradrop", false, { Owner = USA })
	PowerproxyA10 = Actor.Create("powerproxy.a10", false, { Owner = USA })
	PowerproxyArty = Actor.Create("powerproxy.artillery_barrage", false, { Owner = PRC })

	Trigger.AfterDelay(DateTime.Seconds(40), function() SendMiGs(MiG1Waypoints) end)
	Trigger.AfterDelay(DateTime.Seconds(40), function() SendMiGs(MiG2Waypoints) end)

	Trigger.AfterDelay(DateTime.Minutes(4) + DateTime.Seconds(15), function() SendParadrop(PowerproxyPara, DateTime.Minutes(4)) end)
	Trigger.AfterDelay(DateTime.Minutes(4) + DateTime.Seconds(25), function() SendAirstrike(PowerproxyA10, A10Waypoint, Angle.West, DateTime.Minutes(4)) end)
	Trigger.AfterDelay(DateTime.Minutes(5), function() SendAirstrike(PowerproxyArty, ArtyBarrWaypoint, Angle.East, DateTime.Minutes(5)) end)
	SummonActor("hack.rebel_spawner.8", GLA, AmbushLocation1.Location, DateTime.Minutes(4))
end
