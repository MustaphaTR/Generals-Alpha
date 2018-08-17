--[[
   Copyright 2007-2018 The OpenRA Developers (see AUTHORS)
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

EnemyBase = { EnemyCommandCenter, EnemyBarracks, EnemyWarFactory1, EnemyWarFactory2, EnemyAirfield1, EnemyAirfield2, EnemySupplyCenter1, EnemySupplyCenter2, EnemyPropaganda, EnemyReactor1, EnemyReactor2, EnemyReactor3, EnemyReactor4, EnemyReactor5, EnemyReactor6, EnemyReactor7, EnemyReactor8, EnemyReactor9, EnemyReactor10, EnemyReactor11, EnemyReactor12, EnemyReactor13, EnemyReactor14, EnemyReactor15, EnemyGatling1, EnemyGatling2, EnemyGatling3, EnemyGatling4, EnemyGatling5, EnemyGatling6, EnemyGatling7, EnemyGatling8, EnemyGatling9, EnemyGatling10, EnemyGatling11, EnemyGatling12, EnemyGatling13, EnemyGatling14, EnemyGatling15, EnemyBunker1, EnemyBunker2, EnemyBunker3, EnemyBunker4, EnemyBunker5, EnemyBunker6, EnemyBunker7, EnemySpeaker1, EnemySpeaker2, EnemySpeaker3, EnemySpeaker4, EnemySpeaker5 }

RandomTaunts = { "19", "15", "16", "17", "18", "20", "22", "23", "24", "25", "26", "27", "29", "30" }

VehicleAttackForces =
{
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
		{ "vehicle.emparor_overlord" },
		{ "vehicle.emparor_overlord", "vehicle.emparor_overlord" }
	}
}

InfantryAttackForces =
{
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
		for i = 1, #path do
			if unit.HasProperty("AttackMove") then
				unit.AttackMove(path[i].Location)
			else
				unit.Move(path[i].Location)
			end
		end
		IdleHunt(unit)
	end)
end

BuildAttackForce = function(unit_list, factory, paths)
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

		EnemyBunker1.Destroy()
		EnemyBunker2.Destroy()
		EnemyBunker3.Destroy()
		EnemyBunker4.Destroy()
		EnemyBunker5.Destroy()
		EnemyBunker6.Destroy()
		EnemyBunker7.Destroy()

		TrainHackers(enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP1.Location, false )
		TrainHackers(enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP2.Location, false )
	end

	if Difficulty == "normal" then
		enemy.Cash = enemy.Cash + ((enemy.Cash * 17) / 13)

		TrainHackers(enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP1.Location, false )
		TrainHackers(enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP2.Location, false )
	end

	if Difficulty == "hard" then
		player.Cash = player.Cash - ((player.Cash * 3) / 13)
		enemy.Cash = enemy.Cash + ((enemy.Cash * 20) / 13)

		TrainHackers(enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP1.Location, true )
		TrainHackers(enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP2.Location, true )
	end
end

lowPowerTauntTimer = 0
randomTauntTimer = Utils.RandomInteger(DateTime.Seconds(45), DateTime.Seconds(120))
randomTauntToPlay = 1
Tick = function()
	TickGeneralsPowers()

	randomTauntTimer = randomTauntTimer - 1
	if randomTauntTimer == 0 then
		randomTauntTimer = Utils.RandomInteger(DateTime.Seconds(45), DateTime.Seconds(120))
		Media.PlayTauntNotification(enemy, RandomTaunts[randomTauntToPlay])

		if (randomTauntToPlay == 14) then
			randomTauntToPlay = 1
		else
			randomTauntToPlay = randomTauntToPlay + 1
		end
	end

	if 301 > player.Cash and not lowCashTauntPlayed then
		lowCashTauntPlayed = true
		Media.PlayTauntNotification(enemy, "61")
	end

	if player.PowerState == "Low" or player.PowerState == "Critical" then
		if not lowPowerTaunt1Played then
			lowPowerTaunt1Played = true
			Media.PlayTauntNotification(enemy, "59")
		end

		if not lowPowerTaunt2Played and playerRecoveredFromFirstLowPower then
			lowPowerTaunt2Played = true
			Media.PlayTauntNotification(enemy, "60")
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
		Media.PlayTauntNotification(enemy, "80")
	end
	if not wfacBuildTauntPlayed and #player.GetActorsByTypes(WarFactory) > 0 then
		wfacBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "79")
	end
	if not airfBuildTauntPlayed  and #player.GetActorsByTypes(Airfield) > 0 then
		airfBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "78")
	end
	if not oildBuildTauntPlayed  and #player.GetActorsByType("tech.oil_derrick") > 0 then
		oildBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "48")
	end
	if not pcanBuildTauntPlayed  and #player.GetActorsByTypes(ParticleCannon) > 0 then
		pcanBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "65")
	end
	if not scudBuildTauntPlayed  and #player.GetActorsByTypes(ScudStorm) > 0 then
		scudBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "63")
	end
	if not nukeBuildTauntPlayed  and #player.GetActorsByTypes(MissileSilo) > 0 then
		nukeBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "64")
	end
	if not brtnBuildTauntPlayed  and #player.GetActorsByTypes(Burton) > 0 then
		brtnBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "75")
	end
	if not jrmnBuildTauntPlayed  and #player.GetActorsByTypes(Jarmen) > 0 then
		jrmnBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "77")
	end
	if not lotsBuildTauntPlayed  and #player.GetActorsByTypes(Lotus) > 0 then
		lotsBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "76")
	end
	if not builBuildTauntPlayed  and #player.GetActorsByTypes(BaseBuilding) > 7 then
		builBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "70")
	end
	if not defeBuildTauntPlayed  and #player.GetActorsByTypes(BaseDefense) > 5 then
		defeBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "66")
	end
	if not infaBuildTauntPlayed  and #player.GetActorsByTypes(Infantry) > 11 then
		infaBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "69")
	end
	if not tankBuildTauntPlayed  and #player.GetActorsByTypes(Tank) > 5 then
		tankBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "67")
	end
	if not planBuildTauntPlayed  and #player.GetActorsByTypes(Plane) > 3 then
		planBuildTauntPlayed = true
		Media.PlayTauntNotification(enemy, "68")
	end

	if #enemy.GetActorsByType("infantry.hacker") >= HackerCount[Difficulty] * 2 and not HackersBuilt then
		HackersBuilt = true

		if ProductionBegun then
			local path = function() return EnemyAttackPath end
			BuildAttackForce(InfantryAttackForces[Difficulty], EnemyBarracks, path)
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

	DifficultySetup()
	GiveGeneralPowers()
	RepairBase(enemy, EnemyBase, 0.75)

	ResearchUpgrade("building.prc_war_factory", "upgrade.chain_gun")
	ResearchUpgrade("building.prc_airfield", "upgrade.mig_armor")
	ResearchUpgrade("building.propaganda_center", "upgrade.nationalism")
	ResearchUpgrade("building.missile_silo", "upgrade.nuclear_tanks")

	EnemyAttackPath = CenterPaths

	local path = function() return EnemyAttackPath end
	Trigger.AfterDelay(InitialAttackDelay[Difficulty], function()
		ProductionBegun = true
		BuildAttackForce(VehicleAttackForces[Difficulty], EnemyWarFactory1, path)
		BuildAttackForce(VehicleAttackForces[Difficulty], EnemyWarFactory2, path)

		if HackersBuilt then
			BuildAttackForce(InfantryAttackForces[Difficulty], EnemyBarracks, path)
		end
	end)

	Trigger.AfterDelay(BackDoorAttackDelay[Difficulty], function()
		EnemyAttackPath = CenterAndBackDoorPaths
	end)

	Trigger.AfterDelay(FlankAttackDelay[Difficulty], function()
		EnemyAttackPath = AllPaths
	end)

	Trigger.OnAnyKilled(enemy.GetActorsByTypes(CommandCenter), function()
		Media.PlayTauntNotification(enemy, "44")
	end)
	Trigger.OnAnyKilled(enemy.GetActorsByTypes(Barracks), function()
		Media.PlayTauntNotification(enemy, "39")
	end)
	Trigger.OnAnyKilled(enemy.GetActorsByTypes(WarFactory), function()
		Media.PlayTauntNotification(enemy, "40")
	end)
	Trigger.OnAnyKilled(enemy.GetActorsByTypes(Airfield), function()
		Media.PlayTauntNotification(enemy, "41")
	end)
end
