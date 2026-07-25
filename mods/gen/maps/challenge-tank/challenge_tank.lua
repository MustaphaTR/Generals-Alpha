--[[
   Copyright (c) The OpenRA Developers and Contributors
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

EnemyBase = { EnemyCommandCenter, EnemyBarracks, EnemyWarFactory1, EnemyWarFactory2, EnemyAirfield1, EnemyAirfield2, EnemySupplyCenter1, EnemySupplyCenter2, EnemyPropaganda, EnemyReactor1, EnemyReactor2, EnemyReactor3, EnemyReactor4, EnemyReactor5, EnemyReactor6, EnemyReactor7, EnemyReactor8, EnemyReactor9, EnemyReactor10, EnemyReactor11, EnemyReactor12, EnemyReactor13, EnemyReactor14, EnemyReactor15, EnemyGatling1, EnemyGatling2, EnemyGatling3, EnemyGatling4, EnemyGatling5, EnemyGatling6, EnemyGatling7, EnemyGatling8, EnemyGatling9, EnemyGatling10, EnemyGatling11, EnemyGatling12, EnemyGatling13, EnemyGatling14, EnemyGatling15, EnemyBunker1, EnemyBunker2, EnemyBunker3, EnemyBunker4, EnemyBunker5, EnemyBunker6, EnemyBunker7, EnemySpeaker1, EnemySpeaker2, EnemySpeaker3, EnemySpeaker4, EnemySpeaker5 }

RandomTaunts = { "19", "15", "16", "17", "18", "20", "22", "23", "24", "25", "26", "27", "29", "30" }

InfantryAttackForces =
{
	default = {
		easy =
		{
			{ "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.tank_hunter" },
			{ "infantry.tank_hunter" }
		},
		normal =
		{
			{ "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter" }
		},
		hard =
		{
			{ "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" }
		}
	},
	merged = {
		easy =
		{
			{ "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.tank_hunter" },
			{ "infantry.tank_hunter" }
		},
		normal =
		{
			{ "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter" }
		},
		hard =
		{
			{ "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" }
		}
	}
}

VehicleAttackForces =
{
	default = {
		easy =
		{
			{ "vehicle.battlemaster_tank" },
			{ "vehicle.gatling_tank" }
		},
		normal =
		{
			{ "vehicle.battlemaster_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.dragon_tank" },
			{ "vehicle.troop_crawler" },
			{ "vehicle.emparor_overlord" }
		},
		hard =
		{
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.battlemaster_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.dragon_tank" },
			{ "vehicle.dragon_tank", "vehicle.dragon_tank" },
			{ "vehicle.troop_crawler" },
			{ "vehicle.emparor_overlord" },
			{ "vehicle.emparor_overlord", "vehicle.emparor_overlord" }
		}
	},
	merged = {
		easy =
		{
			{ "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.gatling_tank" }
		},
		normal =
		{
			{ "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.dragon_tank" },
			{ "vehicle.assault_troop_crawler" },
			{ "vehicle.emparor_overlord" }
		},
		hard =
		{
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.dragon_tank" },
			{ "vehicle.dragon_tank", "vehicle.dragon_tank" },
			{ "vehicle.troop_crawler" },
			{ "vehicle.emparor_overlord" },
			{ "vehicle.emparor_overlord", "vehicle.emparor_overlord" }
		}
	},
}

AirAttackForces =
{
	default = {
		easy =
		{
			{ "aircraft.mig" }
		},
		normal =
		{
			{ "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig" },
			{ "aircraft.helix" }
		},
		hard =
		{
			{ "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig", "aircraft.mig", "aircraft.mig" },
			{ "aircraft.helix" },
			{ "aircraft.helix", "aircraft.helix" }
		}
	},
	merged = {
		easy =
		{
			{ "aircraft.mig" }
		},
		normal =
		{
			{ "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig" },
			{ "aircraft.assault_helix" }
		},
		hard =
		{
			{ "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig", "aircraft.mig", "aircraft.mig" },
			{ "aircraft.assault_helix" },
			{ "aircraft.assault_helix", "aircraft.assault_helix" }
		}
	}
}

HackerCount =
{
	easy = 2,
	normal = 4,
	hard = 4
}

InitialAttackDelay =
{
	easy = DateTime.Minutes(3),
	normal = DateTime.Minutes(2),
	hard = DateTime.Minutes(1)
}

AirInitialAttackDelay =
{
	easy = DateTime.Minutes(10),
	normal = DateTime.Minutes(8),
	hard = DateTime.Minutes(6)
}

BackDoorAttackDelay =
{
	easy = DateTime.Minutes(4),
	normal = DateTime.Minutes(3),
	hard = DateTime.Minutes(2)
}

FlankAttackDelay =
{
	easy = DateTime.Minutes(5),
	normal = DateTime.Minutes(4),
	hard = DateTime.Minutes(3)
}

EnemyAttackPath = CenterPaths
CenterPaths =
{
	{ CenterStart, CenterWP1, CenterWP2, CenterWP4, CenterWP5, CenterWP9, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP4, CenterWP5, CenterWP9, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP10, CenterEnd2 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP7, CenterWP8, CenterEnd3 },
	{ CenterStart, CenterWP1, CenterWP3, CenterWP11, CenterWP7, CenterWP8, CenterEnd3 }
}

CenterAndBackDoorPaths =
{
	{ CenterStart, CenterWP1, CenterWP2, CenterWP4, CenterWP5, CenterWP9, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP4, CenterWP5, CenterWP9, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP10, CenterEnd2 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP7, CenterWP8, CenterEnd3 },
	{ CenterStart, CenterWP1, CenterWP3, CenterWP11, CenterWP7, CenterWP8, CenterEnd3 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP2, BackDoorWP3, BackDoorEnd3 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP10, BackDoorWP3, BackDoorEnd3 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP10, BackDoorWP11, BackDoorWP9, BackDoorEnd2 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP10, BackDoorWP11, BackDoorWP8, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP10, BackDoorWP11, BackDoorWP9, BackDoorEnd2 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP10, BackDoorWP11, BackDoorWP8, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP5, BackDoorWP6, BackDoorWP7, BackDoorWP8, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP5, BackDoorWP6, BackDoorWP11, BackDoorWP8, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP5, BackDoorWP6, BackDoorWP11, BackDoorWP9, BackDoorEnd2 }
}

AllPaths =
{
	{ CenterStart, CenterWP1, CenterWP2, CenterWP4, CenterWP5, CenterWP9, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP4, CenterWP5, CenterWP9, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP10, CenterEnd2 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP7, CenterWP8, CenterEnd3 },
	{ CenterStart, CenterWP1, CenterWP3, CenterWP11, CenterWP7, CenterWP8, CenterEnd3 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP2, BackDoorWP3, BackDoorEnd3 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP10, BackDoorWP3, BackDoorEnd3 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP10, BackDoorWP11, BackDoorWP9, BackDoorEnd2 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP10, BackDoorWP11, BackDoorWP8, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP10, BackDoorWP11, BackDoorWP9, BackDoorEnd2 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP10, BackDoorWP11, BackDoorWP8, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP5, BackDoorWP6, BackDoorWP7, BackDoorWP8, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP5, BackDoorWP6, BackDoorWP11, BackDoorWP8, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP5, BackDoorWP6, BackDoorWP11, BackDoorWP9, BackDoorEnd2 },
	{ FlankStart, FlankWP1, FlankWP4, FlankWP5, FlankWP8, FlankEnd1 },
	{ FlankStart, FlankWP1, FlankWP4, FlankWP6, FlankWP9, FlankEnd2 },
	{ FlankStart, FlankWP1, FlankWP4, FlankWP7, FlankWP9, FlankEnd2 },
	{ FlankStart, FlankWP2, FlankWP3, FlankWP4, FlankWP5, FlankWP8, FlankEnd1 },
	{ FlankStart, FlankWP2, FlankWP3, FlankWP4, FlankWP6, FlankWP9, FlankEnd2 },
	{ FlankStart, FlankWP2, FlankWP3, FlankWP4, FlankWP7, FlankWP9, FlankEnd2 },
	{ FlankStart, FlankWP2, FlankWP3, FlankWP7, FlankWP9, FlankEnd2 },
	{ FlankStart, FlankWP2, FlankWP3, FlankWP7, FlankWP9, FlankEnd1 }
}

Attack = function(units, paths)
	local path = Utils.Random(paths())
	Utils.Do(units, function(unit)
		if unit.Type == "vehicle.emparor_overlord" then
			unit.Build({"upgrade.overlord_gatling"})
		end
		if unit.Type == "aircraft.helix" or unit.Type == "aircraft.assault_helix" then
			unit.Build({"upgrade.helix_gatling", "upgrade.helix_napalm"})
		end
		for i = 1, #path do
			if unit.HasProperty("AttackMove") then
				unit.AttackMove(path[i].Location)
			else
				unit.Move(path[i].Location)
			end
		end
		if unit.Type ~= "aircraft.mig" then
			IdleHunt(unit)
		else
			InitializeAttackAircraft(unit, player)
		end
	end)
end

BuildAttackForce = function(unit_list, factory, paths)
	if factory.IsDead or factory.Owner ~= enemy then
		return
	end

	factory.Build(Utils.Random(unit_list), function(units)
		Attack(units, paths)

		Trigger.OnAllKilled(units, function()
			BuildAttackForce(unit_list, factory, paths)
		end)
	end)
end

GiveGeneralPowers = function()
	Actor.Create("generals_power.carpet_bombing",		true, { Owner = enemy })
	Actor.Create("generals_power.cluster_mines",		true, { Owner = enemy })
	Actor.Create("generals_power.arty_barrage1",		true, { Owner = enemy })
	Actor.Create("generals_power.emergency_repair1",	true, { Owner = enemy })
	Actor.Create("generals_power.emp",					true, { Owner = enemy })

	if Difficulty == "hard" or Difficulty == "normal" then
		Actor.Create("generals_power.arty_barrage2",		true, { Owner = enemy })
		Actor.Create("generals_power.emergency_repair2",	true, { Owner = enemy })
	end

	if Difficulty == "hard" then
		Actor.Create("generals_power.arty_barrage3",		true, { Owner = enemy })
		Actor.Create("generals_power.emergency_repair3",	true, { Owner = enemy })
	end
end

DifficultySetup = function()
	if Difficulty == "easy" then
		player.Cash = player.Cash + ((player.Cash * 3) / 13)
		enemy.Cash = enemy.Cash + ((enemy.Cash * 14) / 13)
		enemy.GrantCondition("difficulty-easy")

		EnemyBunker1.Destroy()
		EnemyBunker2.Destroy()
		EnemyBunker3.Destroy()
		EnemyBunker4.Destroy()
		EnemyBunker5.Destroy()
		EnemyBunker6.Destroy()
		EnemyBunker7.Destroy()
	end

	if Difficulty == "normal" then
		enemy.Cash = enemy.Cash + ((enemy.Cash * 17) / 13)
		enemy.GrantCondition("difficulty-normal")
	end

	if Difficulty == "hard" then
		player.Cash = player.Cash - ((player.Cash * 3) / 13)
		enemy.Cash = enemy.Cash + ((enemy.Cash * 20) / 13)
		enemy.GrantCondition("difficulty-hard")
	end

	if MergeGenerals then
		TrainHackers(enemy, "infantry.super_hacker", HackerCount[Difficulty], HackerWP1.Location, true )
		TrainHackers(enemy, "infantry.super_hacker", HackerCount[Difficulty], HackerWP2.Location, true )
	else
		TrainHackers(enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP1.Location, true )
		TrainHackers(enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP2.Location, true )
	end
end

lowPowerTauntTimer = 0
randomTauntTimer = Utils.RandomInteger(DateTime.Seconds(45), DateTime.Seconds(120))
randomTauntToPlay = 1
Tick = function()
	if GPModifier ~= "disabled" then
		TickGeneralsPowers()
	end

	randomTauntTimer = randomTauntTimer - 1
	if randomTauntTimer == 0 then
		randomTauntTimer = Utils.RandomInteger(DateTime.Seconds(45), DateTime.Seconds(120))
		Taunts.PlayTauntNotification(enemy, RandomTaunts[randomTauntToPlay])

		if (randomTauntToPlay == 14) then
			randomTauntToPlay = 1
		else
			randomTauntToPlay = randomTauntToPlay + 1
		end
	end

	if 301 > player.Cash and not lowCashTauntPlayed then
		lowCashTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "61")
	end

	if player.PowerState == "Low" or player.PowerState == "Critical" then
		if not lowPowerTaunt1Played then
			lowPowerTaunt1Played = true
			Taunts.PlayTauntNotification(enemy, "59")
		end

		if not lowPowerTaunt2Played and playerRecoveredFromFirstLowPower then
			lowPowerTaunt2Played = true
			Taunts.PlayTauntNotification(enemy, "60")
		end
	end

	if lowPowerTaunt1Played then
		lowPowerTauntTimer = lowPowerTauntTimer + 1
		if player.PowerState == "Normal" and 1501 < lowPowerTauntTimer then
			playerRecoveredFromFirstLowPower = true
		end
	end

	if not barrBuildTauntPlayed and #player.GetActorsByTypes(Barracks) > 0 then
		barrBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "80")
	end
	if not wfacBuildTauntPlayed and #player.GetActorsByTypes(WarFactory) > 0 then
		wfacBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "79")
	end
	if not airfBuildTauntPlayed  and #player.GetActorsByTypes(Airfield) > 0 then
		airfBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "78")
	end
	if not oildBuildTauntPlayed  and #player.GetActorsByType("tech.oil_derrick") > 0 then
		oildBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "48")
	end
	if not pcanBuildTauntPlayed  and #player.GetActorsByTypes(ParticleCannon) > 0 then
		pcanBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "65")
	end
	if not scudBuildTauntPlayed  and #player.GetActorsByTypes(ScudStorm) > 0 then
		scudBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "63")
	end
	if not nukeBuildTauntPlayed  and #player.GetActorsByTypes(MissileSilo) > 0 then
		nukeBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "64")
	end
	if not brtnBuildTauntPlayed  and #player.GetActorsByTypes(Burton) > 0 then
		brtnBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "75")
	end
	if not jrmnBuildTauntPlayed  and #player.GetActorsByTypes(Jarmen) > 0 then
		jrmnBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "77")
	end
	if not lotsBuildTauntPlayed  and #player.GetActorsByTypes(Lotus) > 0 then
		lotsBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "76")
	end
	if not builBuildTauntPlayed  and #player.GetActorsByTypes(BaseBuilding) > 7 then
		builBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "70")
	end
	if not defeBuildTauntPlayed  and #player.GetActorsByTypes(BaseDefense) > 5 then
		defeBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "66")
	end
	if not infaBuildTauntPlayed  and #player.GetActorsByTypes(Infantry) > 11 then
		infaBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "69")
	end
	if not tankBuildTauntPlayed  and #player.GetActorsByTypes(Tank) > 5 then
		tankBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "67")
	end
	if not planBuildTauntPlayed  and #player.GetActorsByTypes(Plane) > 3 then
		planBuildTauntPlayed = true
		Taunts.PlayTauntNotification(enemy, "68")
	end

	if #enemy.GetActorsByTypes(Hacker) >= HackerCount[Difficulty] * 2 and not HackersBuilt then
		HackersBuilt = true

		if ProductionBegun then
			local path = function() return EnemyAttackPath end
			BuildAttackForce(InfantryAttackForces[AttackForceList][Difficulty], EnemyBarracks, path)
		end
	end
end

WorldLoaded = function()
	player = Player.GetPlayer("Multi0")
	enemy = Player.GetPlayer("General Kwai")

	players = { player }

	for _,player in pairs(players) do
		ReducePoints(player)
	end

	MergeGenerals = player.HasPrerequisites({"prerequisite.mergegenerals"})
	AttackForceList = "default"
	if MergeGenerals then
		AttackForceList = "merged"
	end

	DifficultySetup()
	GiveGeneralPowers()
	RepairBase(enemy, EnemyBase, 0.75)

	ResearchUpgrade("building.prc_war_factory", "upgrade.chain_gun")
	ResearchUpgrade("building.prc_airfield", "upgrade.mig_armor")
	if MergeGenerals then
		ResearchUpgrade("building.propaganda_center", "upgrade.patriotism")
	else
		ResearchUpgrade("building.propaganda_center", "upgrade.nationalism")
		ResearchUpgrade("building.missile_silo", "upgrade.nuclear_tanks")
	end

	EnemyAttackPath = CenterPaths

	local path = function() return EnemyAttackPath end
	Trigger.AfterDelay(InitialAttackDelay[Difficulty], function()
		ProductionBegun = true
		BuildAttackForce(VehicleAttackForces[AttackForceList][Difficulty], EnemyWarFactory1, path)
		BuildAttackForce(VehicleAttackForces[AttackForceList][Difficulty], EnemyWarFactory2, path)

		if HackersBuilt then
			BuildAttackForce(InfantryAttackForces[AttackForceList][Difficulty], EnemyBarracks, path)
		end
	end)
	Trigger.AfterDelay(AirInitialAttackDelay[Difficulty], function()
		BuildAttackForce(AirAttackForces[AttackForceList][Difficulty], EnemyAirfield1, path)
		BuildAttackForce(AirAttackForces[AttackForceList][Difficulty], EnemyAirfield2, path)
	end)

	Trigger.OnBuildingPlaced(enemy, function(_, building)
		table.insert(EnemyBase, building)
		RepairBase(enemy, {building}, 0.75 )
		if building.Type == "building.prc_barracks" then
			BuildAttackForce(InfantryAttackForces[AttackForceList][Difficulty], building, path)
		elseif building.Type == "building.prc_war_factory" then
			BuildAttackForce(VehicleAttackForces[AttackForceList][Difficulty], building, path)
		elseif building.Type == "building.prc_airfield" then
			BuildAttackForce(AirAttackForces[AttackForceList][Difficulty], building, path)
		end
	end)

	Trigger.AfterDelay(BackDoorAttackDelay[Difficulty], function()
		EnemyAttackPath = CenterAndBackDoorPaths
	end)
	Trigger.AfterDelay(FlankAttackDelay[Difficulty], function()
		EnemyAttackPath = AllPaths
	end)

	Trigger.OnAnyKilled(enemy.GetActorsByTypes(CommandCenter), function()
		Taunts.PlayTauntNotification(enemy, "44")
	end)
	Trigger.OnAnyKilled(enemy.GetActorsByTypes(Barracks), function()
		Taunts.PlayTauntNotification(enemy, "39")
	end)
	Trigger.OnAnyKilled(enemy.GetActorsByTypes(WarFactory), function()
		Taunts.PlayTauntNotification(enemy, "40")
	end)
	Trigger.OnAnyKilled(enemy.GetActorsByTypes(Airfield), function()
		Taunts.PlayTauntNotification(enemy, "41")
	end)
end
