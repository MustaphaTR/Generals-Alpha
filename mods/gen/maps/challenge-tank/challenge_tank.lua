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
		if IsPlane(unit) then
			InitializeAttackAircraft(unit, MP0)
		else
			IdleHunt(unit)
		end
	end)
end

BuildAttackForce = function(unit_list, factory, paths)
	if factory.IsDead or factory.Owner ~= Enemy then
		return
	end

	factory.Build(Utils.Random(unit_list), function(units)
		Attack(units, paths)

		Trigger.OnAllKilled(units, function()
			BuildAttackForce(unit_list, factory, paths)
		end)
	end)
end

InitializeAttackProduction = function(building)
	if building.Type == "building.prc_barracks" then
		BuildAttackForce(InfantryAttackForces[AttackForceList][Difficulty], building, function() return EnemyAttackPath end)
	elseif building.Type == "building.prc_war_factory" then
		BuildAttackForce(VehicleAttackForces[AttackForceList][Difficulty], building, function() return EnemyAttackPath end)
	elseif building.Type == "building.prc_airfield" then
		BuildAttackForce(AirAttackForces[AttackForceList][Difficulty], building, function() return EnemyAttackPath end)
	end
end

GiveGeneralPowers = function()
	Actor.Create("generals_power.carpet_bombing",		true, { Owner = Enemy })
	Actor.Create("generals_power.cluster_mines",		true, { Owner = Enemy })
	Actor.Create("generals_power.arty_barrage1",		true, { Owner = Enemy })
	Actor.Create("generals_power.emergency_repair1",	true, { Owner = Enemy })
	Actor.Create("generals_power.emp",					true, { Owner = Enemy })

	if Difficulty == "hard" or Difficulty == "normal" then
		Actor.Create("generals_power.arty_barrage2",		true, { Owner = Enemy })
		Actor.Create("generals_power.emergency_repair2",	true, { Owner = Enemy })
	end

	if Difficulty == "hard" then
		Actor.Create("generals_power.arty_barrage3",		true, { Owner = Enemy })
		Actor.Create("generals_power.emergency_repair3",	true, { Owner = Enemy })
	end
end

DifficultySetup = function()
	if Difficulty == "easy" then
		MP0.Cash = MP0.Cash + ((MP0.Cash * 3) / 13)
		Enemy.Cash = Enemy.Cash + ((Enemy.Cash * 14) / 13)
		Enemy.GrantCondition("difficulty-easy")

		EnemyBunker1.Destroy()
		EnemyBunker2.Destroy()
		EnemyBunker3.Destroy()
		EnemyBunker4.Destroy()
		EnemyBunker5.Destroy()
		EnemyBunker6.Destroy()
		EnemyBunker7.Destroy()
	end

	if Difficulty == "normal" then
		Enemy.Cash = Enemy.Cash + ((Enemy.Cash * 17) / 13)
		Enemy.GrantCondition("difficulty-normal")
	end

	if Difficulty == "hard" then
		MP0.Cash = MP0.Cash - ((MP0) / 13)
		Enemy.Cash = Enemy.Cash + ((Enemy.Cash * 20) / 13)
		Enemy.GrantCondition("difficulty-hard")
	end

	if MergeGenerals then
		TrainHackers(Enemy, "infantry.super_hacker", HackerCount[Difficulty], HackerWP1.Location, true )
		TrainHackers(Enemy, "infantry.super_hacker", HackerCount[Difficulty], HackerWP2.Location, true )
	else
		TrainHackers(Enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP1.Location, true )
		TrainHackers(Enemy, "infantry.hacker", HackerCount[Difficulty], HackerWP2.Location, true )
	end
end

LowPowerTauntTimer = 0
RandomTauntTimer = Utils.RandomInteger(DateTime.Seconds(45), DateTime.Seconds(120))
RandomTauntToPlay = 1
Tick = function()
	if GPModifier ~= "disabled" then
		TickGeneralsPowers()
	end

	RandomTauntTimer = RandomTauntTimer - 1
	if RandomTauntTimer == 0 then
		RandomTauntTimer = Utils.RandomInteger(DateTime.Seconds(45), DateTime.Seconds(120))
		Taunts.PlayTauntNotification(Enemy, RandomTaunts[RandomTauntToPlay])

		if (RandomTauntToPlay == 14) then
			RandomTauntToPlay = 1
		else
			RandomTauntToPlay = RandomTauntToPlay + 1
		end
	end

	if 301 > MP0.Cash and not LowCashTauntPlayed then
		LowCashTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "61")
	end

	if MP0.PowerState == "Low" or MP0.PowerState == "Critical" then
		if not LowPowerTaunt1Played then
			LowPowerTaunt1Played = true
			Taunts.PlayTauntNotification(Enemy, "59")
		end

		if not LowPowerTaunt2Played and PlayerRecoveredFromFirstLowPower then
			LowPowerTaunt2Played = true
			Taunts.PlayTauntNotification(Enemy, "60")
		end
	end

	if LowPowerTaunt1Played then
		LowPowerTauntTimer = LowPowerTauntTimer + 1
		if MP0.PowerState == "Normal" and 1501 < LowPowerTauntTimer then
			PlayerRecoveredFromFirstLowPower = true
		end
	end

	if not BarrBuildTauntPlayed and #MP0.GetActorsByTypes(Barracks) > 0 then
		BarrBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "80")
	end
	if not WFacBuildTauntPlayed and #MP0.GetActorsByTypes(WarFactory) > 0 then
		WFacBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "79")
	end
	if not AirfBuildTauntPlayed and #MP0.GetActorsByTypes(Airfield) > 0 then
		AirfBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "78")
	end
	if not PCanBuildTauntPlayed and #MP0.GetActorsByTypes(ParticleCannon) > 0 then
		PCanBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "65")
	end
	if not ScudBuildTauntPlayed and #MP0.GetActorsByTypes(ScudStorm) > 0 then
		ScudBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "63")
	end
	if not NukeBuildTauntPlayed and #MP0.GetActorsByTypes(MissileSilo) > 0 then
		NukeBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "64")
	end
	if not BrtnBuildTauntPlayed and #MP0.GetActorsByTypes(Burton) > 0 then
		BrtnBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "75")
	end
	if not JrmnBuildTauntPlayed and #MP0.GetActorsByTypes(Jarmen) > 0 then
		JrmnBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "77")
	end
	if not LotsBuildTauntPlayed and #MP0.GetActorsByTypes(Lotus) > 0 then
		LotsBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "76")
	end
	if not BuilBuildTauntPlayed and #MP0.GetActorsByTypes(BaseBuilding) > 7 then
		BuilBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "70")
	end
	if not DefeBuildTauntPlayed and #MP0.GetActorsByTypes(BaseDefense) > 5 then
		DefeBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "66")
	end
	if not InfaBuildTauntPlayed and #MP0.GetActorsByTypes(Infantry) > 11 then
		InfaBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "69")
	end
	if not TankBuildTauntPlayed and #MP0.GetActorsByTypes(Tank) > 5 then
		TankBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "67")
	end
	if not PlanBuildTauntPlayed and #MP0.GetActorsByTypes(Plane) > 3 then
		PlanBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "68")
	end

	if #Enemy.GetActorsByTypes(Hacker) >= HackerCount[Difficulty] * 2 and not HackersBuilt then
		HackersBuilt = true

		if ProductionBegun then
			local path = function() return EnemyAttackPath end
			BuildAttackForce(InfantryAttackForces[AttackForceList][Difficulty], EnemyBarracks, path)
		end
	end
end

WorldLoaded = function()
	Players = Player.GetPlayers(function(p) return not p.IsNonCombatant end)
	SetUpDefaults()

	for _,player in pairs(Players) do
		ReducePoints(player)
	end

	Neutral = Player.GetPlayer("Neutral")
	MP0 = Player.GetPlayer("Multi0")
	Enemy = Player.GetPlayer("ChallengeGeneral")

	MergeGenerals = MP0.HasPrerequisites({"prerequisite.mergegenerals"})
	AttackForceList = "default"
	if MergeGenerals then
		AttackForceList = "merged"
	end

	DifficultySetup()
	GiveGeneralPowers()

	ResearchUpgrade("building.prc_war_factory", "upgrade.chain_gun")
	ResearchUpgrade("building.prc_airfield", "upgrade.mig_armor")
	if MergeGenerals then
		ResearchUpgrade("building.propaganda_center", "upgrade.patriotism")
	else
		ResearchUpgrade("building.propaganda_center", "upgrade.nationalism")
		ResearchUpgrade("building.missile_silo", "upgrade.nuclear_tanks")
	end

	EnemyAttackPath = CenterPaths
	Trigger.AfterDelay(InitialAttackDelay[Difficulty], function()
		ProductionBegun = true
		Utils.Do(Enemy.GetActorsByType("building.prc_war_factory"), function(building)
			InitializeAttackProduction(building)
		end)

		if HackersBuilt then
			Utils.Do(Enemy.GetActorsByType("building.prc_barracks"), function(building)
				InitializeAttackProduction(building)
			end)
		end
	end)
	Trigger.AfterDelay(AirInitialAttackDelay[Difficulty], function()
		Utils.Do(Enemy.GetActorsByType("building.prc_airfield"), function(building)
			InitializeAttackProduction(building)
		end)
	end)

	Trigger.OnBuildingPlaced(Enemy, function(_, building)
		table.insert(EnemyBase, building)

		if ProductionBegun then
			InitializeAttackProduction(building)
		end
	end)

	Trigger.AfterDelay(BackDoorAttackDelay[Difficulty], function()
		EnemyAttackPath = CenterAndBackDoorPaths
	end)
	Trigger.AfterDelay(FlankAttackDelay[Difficulty], function()
		EnemyAttackPath = AllPaths
	end)

	Utils.Do(Neutral.GetActorsByType("tech.oil_derrick"), function(oild)
		Trigger.OnCapture(oild, function(_, _, _, newOwner)
			if not OildBuildTauntPlayed and newOwner == MP0 then
				OildBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "48")
			end
		end)
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(CommandCenter), function()
		Taunts.PlayTauntNotification(Enemy, "44")
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(Barracks), function()
		Taunts.PlayTauntNotification(Enemy, "39")
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(WarFactory), function()
		Taunts.PlayTauntNotification(Enemy, "40")
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(Airfield), function()
		Taunts.PlayTauntNotification(Enemy, "41")
	end)
end
