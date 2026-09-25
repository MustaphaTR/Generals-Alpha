--[[
   Copyright (c) The OpenRA Developers and Contributors
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

EnemyBase = { EnemyCommandCenter, EnemyBarracks, EnemyAirfield1, EnemyAirfield2, EnemyAirfield3, EnemySupplyCenter, EnemySupplyDrop1, EnemySupplyDrop2, EnemyReactor1, EnemyReactor2, EnemyReactor3, EnemyReactor4, EnemyReactor5, EnemyReactor6, EnemyReactor7, EnemyReactor8, EnemyReactor9, EnemyReactor10, EnemyReactor11, EnemyReactor12, EnemyPatriot1, EnemyPatriot2, EnemyPatriot3, EnemyPatriot4, EnemyPatriot5, EnemyPatriot6, EnemyPatriot7, EnemyPatriot8, EnemyPatriot9, EnemyPatriot10, EnemyPatriot11 }

RandomTaunts = {
	{ "13", 5 },
	{ "14", 5 },
	{ "15", 3 },
	{ "16", 7 },
	{ "17", 4 }
}

DerricksToCapture = {
	easy = { OilDerrick1, OilDerrick2 },
	normal = { OilDerrick3, OilDerrick4, OilDerrick5 },
	hard = { OilDerrick1, OilDerrick2, OilDerrick3, OilDerrick4, OilDerrick5 }
}

GarrisonableBuildings = {
	easy = { WindmillVillage, LHouseVillage1, LHouseVillage2, SmallHouseVillage1, SmallHouseVillage2, SmallHouseVillage3, SmallHouseVillage4, SmallHouseVillage5, SmallHouseVillage6, SmallHouseVillage7, SmallHouseVillage8, MediumHouseVillage1, MediumHouseVillage2, MediumHouseVillage3, MediumHouseVillage4, MediumHouseVillage5, MediumHouseVillage6, MediumHouseVillage7, ChurchVillage, BigHouseVillage1, BigHouseVillage2, BigHouseVillage3, BigHouseVillage4, BigHouseVillage5, BigHouseVillage6 },
	normal = { LHouseBridgeVillage, WindmillVillage, LHouseVillage1, LHouseVillage2, SmallHouseVillage1, SmallHouseVillage2, SmallHouseVillage3, SmallHouseVillage4, SmallHouseVillage5, SmallHouseVillage6, SmallHouseVillage7, SmallHouseVillage8, MediumHouseVillage1, MediumHouseVillage2, MediumHouseVillage3, MediumHouseVillage4, MediumHouseVillage5, MediumHouseVillage6, MediumHouseVillage7, ChurchVillage, BigHouseVillage1, BigHouseVillage2, BigHouseVillage3, BigHouseVillage4, BigHouseVillage5, BigHouseVillage6 },
	hard = { MediumHouseVillage1, MediumHouseVillage2, MediumHouseVillage3, MediumHouseVillage4, MediumHouseVillage5, MediumHouseVillage6, MediumHouseVillage7, ChurchVillage, BigHouseVillage1, BigHouseVillage2, BigHouseVillage3, BigHouseVillage4, BigHouseVillage5, BigHouseVillage6 }
}
MaxGarrisonTeams = {
	easy = 1,
	normal = 3,
	hard = 5
}
GarrisonTeams = {
	easy = {
		{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender" }
	},
	normal = {
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" }
	},
	hard = {
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" },
	}
}

ChinookTeams = {
	{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" },
	{ "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" }
}

InfantryAttackForces = {
	easy = {
		{ "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.missile_defender" },
		{ "infantry.missile_defender", "infantry.missile_defender" }
	},
	normal = {
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" }
	},
	hard = {
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" }
	}
}

AirAttackForces = {
	default = {
		easy = {
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.comanche" }
		},
		normal = {
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.stealth_fighter" },
			{ "aircraft.aurora" },
			{ "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche" }
		},
		hard = {
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.stealth_fighter" },
			{ "aircraft.stealth_fighter", "aircraft.stealth_fighter" },
			{ "aircraft.aurora" },
			{ "aircraft.aurora", "aircraft.aurora" },
			{ "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche", "aircraft.comanche" }
		}
	},
	merged = {
		easy = {
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.comanche" }
		},
		normal = {
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.stealth_fighter" },
			{ "aircraft.aurora_alpha" },
			{ "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche" }
		},
		hard = {
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.stealth_fighter" },
			{ "aircraft.stealth_fighter", "aircraft.stealth_fighter" },
			{ "aircraft.aurora_alpha" },
			{ "aircraft.aurora_alpha", "aircraft.aurora_alpha" },
			{ "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche", "aircraft.comanche" }
		}
	}
}

InitialAttackDelay = {
	easy = DateTime.Minutes(3),
	normal = DateTime.Minutes(2),
	hard = DateTime.Minutes(1)
}

BackDoorAttackDelay = {
	easy = DateTime.Minutes(4),
	normal = DateTime.Minutes(3),
	hard = DateTime.Minutes(2)
}

FlankAttackDelay = {
	easy = DateTime.Minutes(5),
	normal = DateTime.Minutes(4),
	hard = DateTime.Minutes(3)
}

EnemyAttackPath = CenterPaths
CenterPaths = {
	{ CenterStart, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd2 },
	{ CenterStart, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP3, CenterEnd2 }
}

FlankPaths = {
	{ FlankStart, FlankWP1, FlankWP2, FlankWP3, FlankWP4, FlankEnd1 }
}

CenterAndBackDoorPaths = {
	{ CenterStart, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd2 },
	{ CenterStart, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP3, CenterEnd2 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP2, BackDoorWP3, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP9, BackDoorWP5, BackDoorWP6, BackDoorWP7, BackDoorWP8, BackDoorEnd2 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP9, BackDoorWP10, BackDoorWP11, BackDoorEnd3 }
}

AllPaths = {
	{ CenterStart, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd2 },
	{ CenterStart, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP3, CenterEnd2 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP2, BackDoorWP3, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP9, BackDoorWP5, BackDoorWP6, BackDoorWP7, BackDoorWP8, BackDoorEnd2 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP9, BackDoorWP10, BackDoorWP11, BackDoorEnd3 },
	{ FlankStart, FlankWP1, FlankWP2, FlankWP3, FlankWP4, FlankEnd1 }
}

CinematicPaths = {
	{ CinematicStart1.Location, CinematicEnd1.Location },
	{ CinematicStart2.Location, CinematicEnd2.Location },
	{ CinematicStart3.Location, CinematicEnd3.Location },
	{ CinematicStart4.Location, CinematicEnd4.Location }
}

InnerComanchePath = { InnerComancheWP1.Location, InnerComancheWP2.Location, InnerComancheWP3.Location, InnerComancheWP4.Location, InnerComancheWP5.Location }
OuterComanchePath = { OuterComancheWP1.Location, OuterComancheWP2.Location, OuterComancheWP3.Location, OuterComancheWP4.Location }

Attack = function(units, paths)
	local path = Utils.Random(paths())
	Utils.Do(units, function(unit)
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

	local built = factory.Build(Utils.Random(unit_list), function(units)
		Attack(units, paths)

		Trigger.OnAllKilled(units, function()
			BuildAttackForce(unit_list, factory, paths)
		end)
	end)
	if not built then
		Trigger.AfterDelay(DateTime.Seconds(15), function()
			BuildAttackForce(unit_list, factory, paths)
		end)
	end
end

BuildCombatChinookForce = function(chinook, unit_list, factory, paths)
	if chinook.IsDead then
		return
	end

	local factories = chinook.Owner.GetActorsByType(factory)
	if #factories > 0 then
		local built = Utils.Random(factories).Build(Utils.Random(unit_list), function(units)
			chinook.Move(CombatChinookLoadWP.Location)
			Utils.Do(units, function(unit)
				unit.EnterTransport(chinook)
			end)
			Trigger.OnAllRemovedFromWorld(units, function()
				if not chinook.IsSupplyEmpty then
					chinook.DeliverGoods()
				end
				Attack({ chinook }, paths)
			end)
		end)
		if not built then
			Trigger.AfterDelay(DateTime.Seconds(15), function()
				BuildCombatChinookForce(chinook, unit_list, factory, paths)
			end)
		end
	else
		Trigger.AfterDelay(DateTime.Seconds(30), function()
			BuildCombatChinookForce(chinook, unit_list, factory, paths)
		end)
	end
end

InitializeAttackProduction = function(building)
	if building.Type == "building.usa_barracks" then
		BuildAttackForce(InfantryAttackForces[Difficulty], building, function() return FlankPaths end)
	elseif building.Type == "building.usa_airfield" then
		BuildAttackForce(AirAttackForces[AttackForceList][Difficulty], building, function() return EnemyAttackPath end)
	end
end

CurrentGarrisonTeamCount = 0
BuildGarrisonForce = function(producer)
	local validGarrisonables = Utils.Where(GarrisonableBuildings[Difficulty], function(a)
		return a.Owner == Neutral and a.Health > a.MaxHealth * 0.25
	end)
	if #validGarrisonables > 0 then
		TrainGarrisoners(Enemy, Utils.Random(GarrisonTeams[Difficulty]), producer, validGarrisonables)
		CurrentGarrisonTeamCount = CurrentGarrisonTeamCount + 1
		if CurrentGarrisonTeamCount < MaxGarrisonTeams[Difficulty] then
			Trigger.AfterDelay(DateTime.Minutes(2), function()
				BuildGarrisonForce(producer)
			end)
		end
	else
		Trigger.AfterDelay(DateTime.Minutes(2), function()
			BuildGarrisonForce(producer)
		end)
	end
end

SendCinematicAircraft = function()
	Reinforcements.Reinforce(Enemy, { "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" }, CinematicPaths[1], 2, function(unit) unit.Destroy() end)
	Reinforcements.Reinforce(Enemy, { "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" }, CinematicPaths[2], 2, function(unit) unit.Destroy() end)
	Reinforcements.Reinforce(Enemy, { "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" }, CinematicPaths[3], 2, function(unit) unit.Destroy() end)
	Reinforcements.Reinforce(Enemy, { "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" }, CinematicPaths[4], 2, function(unit) unit.Destroy() end)
	Trigger.AfterDelay(DateTime.Seconds(8), function()
		Taunts.PlayTauntNotification(Enemy, "68")
		Trigger.AfterDelay(DateTime.Seconds(6), function()
			Media.PlaySpeechNotification(MP0, "RaptorCreated")
			Trigger.AfterDelay(DateTime.Seconds(5), function()
				Taunts.PlayTauntNotification(Enemy, "69")
				SetTauntPlaying(DateTime.Seconds(3))

				Trigger.OnEnteredProximityTrigger(PlayerBaseCenter.CenterPosition, WDist.New(20 * 1024), function(a, id)
					if a.Owner == Enemy and not TauntPlaying and IsPlane(a) and #Map.ActorsInCircle(PlayerBaseCenter.CenterPosition, WDist.New(20 * 1024), function(a) return a.Owner == Enemy and IsPlane(a) end) > 1 then
						Trigger.RemoveProximityTrigger(id)
						Taunts.PlayTauntNotification(Enemy, "9")
						SetTauntPlaying(DateTime.Seconds(2))
					end
				end)
			end)
		end)
	end)
end

DifficultySetup = function()
	if Difficulty == "easy" then
		MP0.Cash = MP0.Cash + ((MP0.Cash * 3) / 13)
		Enemy.Cash = Enemy.Cash + ((Enemy.Cash * 14) / 13)

		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", InnerComanchePath, DateTime.Seconds(15))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", OuterComanchePath, DateTime.Seconds(15))
	end

	if Difficulty == "normal" then
		Enemy.Cash = Enemy.Cash + ((Enemy.Cash * 17) / 13)

		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", InnerComanchePath, DateTime.Seconds(15))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", InnerComanchePath, DateTime.Seconds(20))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", OuterComanchePath, DateTime.Seconds(15))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", OuterComanchePath, DateTime.Seconds(20))
	end

	if Difficulty == "hard" then
		MP0.Cash = MP0.Cash - ((MP0.Cash * 3) / 13)
		Enemy.Cash = Enemy.Cash + ((Enemy.Cash * 20) / 13)

		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", InnerComanchePath, DateTime.Seconds(10))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", InnerComanchePath, DateTime.Seconds(15))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", InnerComanchePath, DateTime.Seconds(20))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", OuterComanchePath, DateTime.Seconds(10))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", OuterComanchePath, DateTime.Seconds(15))
		TrainPatrolDefense(Enemy, { "aircraft.comanche" }, "building.usa_airfield", OuterComanchePath, DateTime.Seconds(20))
	end
end

KilledAirfields = 0
PlayAirfieldKilledTaunt = function()
	if not TauntPlaying then
		if KilledAirfields == 0 then
			Taunts.PlayTauntNotification(Enemy, "28")
			SetTauntPlaying(DateTime.Seconds(3))
			KilledAirfields = KilledAirfields + 1
		elseif KilledAirfields == 1 then
			Taunts.PlayTauntNotification(Enemy, "72")
			SetTauntPlaying(DateTime.Seconds(5))
			KilledAirfields = KilledAirfields + 1
		elseif KilledAirfields == 2 then
			Taunts.PlayTauntNotification(Enemy, "73")
			SetTauntPlaying(DateTime.Seconds(5))
			KilledAirfields = KilledAirfields + 1
		elseif KilledAirfields == 3 then
			Taunts.PlayTauntNotification(Enemy, "74")
			SetTauntPlaying(DateTime.Seconds(6))
			KilledAirfields = KilledAirfields + 1
		elseif KilledAirfields == 4 then
			Taunts.PlayTauntNotification(Enemy, "37")
			SetTauntPlaying(DateTime.Seconds(3))
			KilledAirfields = KilledAirfields + 1
		end
	end
end

SetupSupportPowerNotifications = function(building)
	if building.Owner == Enemy then
		Trigger.OnSupportPowerActivated(building, function(_, orderName)
			if not ParadropTauntPlayed and not TauntPlaying and orderName == "ParadropPowerInfoOrder" then
				ParadropTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "71")
				SetTauntPlaying(DateTime.Seconds(4))
			end
			if not FABTauntPlayed and not TauntPlaying and orderName == "FuelAirBombPowerInfoOrder" then
				FABTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "82")
				SetTauntPlaying(DateTime.Seconds(8))
			end
			if not A10TauntPlayed and not TauntPlaying and orderName == "A10PowerInfoOrder" then
				A10TauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "84")
				SetTauntPlaying(DateTime.Seconds(6))
			end
		end)
	elseif building.Owner == MP0 then
		Trigger.OnSupportPowerActivated(building, function(_, orderName)
			if not AnthraxTauntPlayed and not TauntPlaying and orderName == "AnthraxBombPowerInfoOrder" then
				AnthraxTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "54")
				SetTauntPlaying(DateTime.Seconds(3))
			end
		end)
	end
end

RandomTauntToPlay = 1
PlayRandomTaunt = function()
	Trigger.AfterDelay(Utils.RandomInteger(DateTime.Seconds(45), DateTime.Seconds(75)), function()
		if (#Map.ActorsInCircle(PlayerBaseCenter.CenterPosition, WDist.New(30 * 1024), function(a) return a.Owner == Enemy and IsAircraft(a) end) < 2) then
			Taunts.PlayTauntNotification(Enemy, RandomTaunts[RandomTauntToPlay][1])
			SetTauntPlaying(RandomTaunts[RandomTauntToPlay][2])

			if (RandomTauntToPlay == 5) then
				RandomTauntToPlay = 1
			else
				RandomTauntToPlay = RandomTauntToPlay + 1
			end
		end

		PlayRandomTaunt()
	end)
end

LowPowerTauntTimer = 0
Tick = function()
	if GPModifier ~= "disabled" then
		TickGeneralsPowers()
	end

	if 301 > MP0.Cash and not LowCashTauntPlayed and not TauntPlaying then
		LowCashTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "48")
		SetTauntPlaying(DateTime.Seconds(6))
	end

	if MP0.PowerState == "Low" or MP0.PowerState == "Critical" then
		if not LowPowerTaunt1Played and not TauntPlaying then
			LowPowerTaunt1Played = true
			Taunts.PlayTauntNotification(Enemy, "46")
			SetTauntPlaying(DateTime.Seconds(3))
		end

		if not LowPowerTaunt2Played and PlayerRecoveredFromFirstLowPower and not TauntPlaying then
			LowPowerTaunt2Played = true
			Taunts.PlayTauntNotification(Enemy, "47")
			SetTauntPlaying(DateTime.Seconds(4))
		end
	end

	if LowPowerTaunt1Played then
		LowPowerTauntTimer = LowPowerTauntTimer + 1
		if MP0.PowerState == "Normal" and 1501 < LowPowerTauntTimer then
			PlayerRecoveredFromFirstLowPower = true
		end
	end

	if Enemy.PowerState == "Low" or Enemy.PowerState == "Critical" then
		if not EnemyLowPowerTauntPlayed and not TauntPlaying then
			EnemyLowPowerTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "49")
			SetTauntPlaying(DateTime.Seconds(5))
		end
	end

	if not RangerBuildTauntPlayed and not TauntPlaying and #MP0.GetActorsByType("infantry.ranger") > 9 then
		RangerBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "81")
		SetTauntPlaying(DateTime.Seconds(5))
	end
	if not GarrisonTauntPlayed and not TauntPlaying and #MP0.GetActorsByTypes(CivilianBuilding) > 5 then
		GarrisonTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "55")
		SetTauntPlaying(DateTime.Seconds(5))
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

	Trigger.OnObjectiveCompleted(MP0, function()
		Taunts.PlayTauntNotification(Enemy, "64")
		SetTauntPlaying(DateTime.Seconds(4))
	end)

	EnemyAttackPath = CenterPaths
	Trigger.AfterDelay(InitialAttackDelay[Difficulty], function()
		ProductionBegun = true
		Utils.Do(Enemy.GetActorsByTypes({"building.usa_barracks", "building.usa_airfield"}), function(building)
			InitializeAttackProduction(building)
		end)

		Taunts.PlayTauntNotification(Enemy, "70")
		SetTauntPlaying(DateTime.Seconds(3))
	end)
	Trigger.AfterDelay(InitialAttackDelay[Difficulty] / 2, function()
		BuildGarrisonForce("building.usa_barracks")
		Taunts.PlayTauntNotification(Enemy, "14")
		SetTauntPlaying(DateTime.Seconds(5))
	end)

	Trigger.OnBuildingPlaced(Enemy, function(_, building)
		table.insert(EnemyBase, building)

		if ProductionBegun then
			InitializeAttackProduction(building)
		end
		if building.Type == "building.usa_airfield" then
			Trigger.OnKilledOrCaptured(building, function()
				PlayAirfieldKilledTaunt()
			end)
		end
		if building.Type == "building.usa_command_center" then
			SetupSupportPowerNotifications(building)
		end
	end)

	Trigger.AfterDelay(BackDoorAttackDelay[Difficulty], function()
		EnemyAttackPath = CenterAndBackDoorPaths
	end)
	Trigger.AfterDelay(FlankAttackDelay[Difficulty], function()
		EnemyAttackPath = AllPaths
	end)

	Taunts.PlayTauntNotification(Enemy, "66")
	Trigger.AfterDelay(DateTime.Seconds(8), function()
		Taunts.PlayTauntNotification(Enemy, "67")
		SendCinematicAircraft()
	end)
	Utils.Do(DerricksToCapture["hard"], function(oild)
		Trigger.OnCapture(oild, function(_, _, oldOwner, newOwner)
			if not OildBuildTauntPlayed and not TauntPlaying and newOwner == MP0 then
				OildBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "33")
				SetTauntPlaying(DateTime.Seconds(5))
			end
			if oldOwner == Enemy then
				CaptureTechBuildings(Enemy, { oild }, "building.usa_barracks", "infantry.ranger")
			end
		end)
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(CommandCenter), function()
		Taunts.PlayTauntNotification(Enemy, "11")
		SetTauntPlaying(DateTime.Seconds(3))
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(Barracks), function()
		Taunts.PlayTauntNotification(Enemy, "30")
		SetTauntPlaying(DateTime.Seconds(7))
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(BaseDefense), function()
		Taunts.PlayTauntNotification(Enemy, "29")
		SetTauntPlaying(DateTime.Seconds(3))
	end)
	Utils.Do(Enemy.GetActorsByTypes(Airfield), function(airf)
		Trigger.OnKilledOrCaptured(airf, function()
			PlayAirfieldKilledTaunt()
		end)
	end)
	SetupSupportPowerNotifications(EnemyCommandCenter)
	SetupSupportPowerNotifications(MP0.GetActorsByTypes(CommandCenter)[1])

	Trigger.OnEnteredProximityTrigger(EnemyBaseCenter.CenterPosition, WDist.New(17 * 1024), function(a, id)
		if a.Owner == MP0 and not TauntPlaying and IsAircraft(a) then
			Trigger.RemoveProximityTrigger(id)
			Taunts.PlayTauntNotification(Enemy, "35")
			SetTauntPlaying(DateTime.Seconds(2))
		end
	end)
	Trigger.OnEnteredProximityTrigger(SupplyDockNorth.CenterPosition, WDist.New(8 * 1024), function(a, id)
		if a.Owner == MP0 and not TauntPlaying and IsSupplyCollector(a) or IsDozer(a) then
			Trigger.RemoveProximityTrigger(id)
			if not ExpansionTauntPlayed then
				ExpansionTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "38")
				SetTauntPlaying(DateTime.Seconds(4))
			end
		end
	end)
	Trigger.OnEnteredProximityTrigger(SupplyDockSouth.CenterPosition, WDist.New(6 * 1024), function(a, id)
		if a.Owner == MP0 and not TauntPlaying and IsSupplyCollector(a) or IsDozer(a) then
			Trigger.RemoveProximityTrigger(id)
			if not ExpansionTauntPlayed then
				ExpansionTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "38")
				SetTauntPlaying(DateTime.Seconds(4))
			end
		end
	end)

	Trigger.OnAnyProduction(function(_, actor)
		if actor.Owner == Enemy then
			if actor.Type == "aircraft.combat_chinook" then
				BuildCombatChinookForce(actor, ChinookTeams, "building.usa_barracks", function() return FlankPaths end)
			end
			if actor.Type == "upgrade.capture_building" then
				CaptureTechBuildings(Enemy, DerricksToCapture[Difficulty], "building.usa_barracks", "infantry.ranger")
			end

			if not EnemyAuroraTauntPlayed and not TauntPlaying and IsAurora(actor) and #Enemy.GetActorsByTypes(Aurora) > 1 then
				EnemyAuroraTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "7")
				SetTauntPlaying(DateTime.Seconds(3))
			elseif not EnemyPlaneTauntPlayed and not TauntPlaying and IsPlane(actor) and #Enemy.GetActorsByTypes(Plane) > 9 then
				EnemyPlaneTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "8")
				SetTauntPlaying(DateTime.Seconds(4))
			end
			if not EnemyAuroraKilledTauntPlayed and IsAurora(actor) then
				Trigger.OnKilled(actor, function()
					if not EnemyAuroraKilledTauntPlayed and not TauntPlaying then
						EnemyAuroraKilledTauntPlayed = true
						Taunts.PlayTauntNotification(Enemy, "32")
						SetTauntPlaying(DateTime.Seconds(3))
					end
				end)
			end
		end

		if actor.Owner == MP0 then
			if (not PlayerDamagedTauntPlayed or not RandomTauntsStarted) and actor.HasProperty("Health") then
				Trigger.OnDamaged(actor, function(_, attacker)
					if attacker.Owner == Enemy then
						if not PlayerDamagedTauntPlayed and not TauntPlaying then
							PlayerDamagedTauntPlayed = true
							Taunts.PlayTauntNotification(Enemy, "5")
							SetTauntPlaying(DateTime.Seconds(5))
						end

						if not RandomTauntsStarted then
							RandomTauntsStarted = true
							PlayRandomTaunt()
						end
					end
				end)
			end

			if not DozerBuildTauntPlayed and not TauntPlaying and IsDozer(actor) and #MP0.GetActorsByTypes(Dozer) > 4 then
				DozerBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "3")
				SetTauntPlaying(DateTime.Seconds(4))
			end
			if not BurtonBuildTauntPlayed and not TauntPlaying and IsBurton(actor) then
				BurtonBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "83")
				SetTauntPlaying(DateTime.Seconds(5))
			end
			if not TankBuildTauntPlayed and not TauntPlaying and IsTank(actor) and #MP0.GetActorsByTypes(Tank) > 3 then
				TankBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "53")
				SetTauntPlaying(DateTime.Seconds(4))
			end
			if not ScudLauncherBuildTauntPlayed and not TauntPlaying and actor.Type == "vehicle.scud_launcher" then
				ScudLauncherBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "87")
				SetTauntPlaying(DateTime.Seconds(6))
			elseif not ArtyBuildTauntPlayed and not TauntPlaying and IsArtillery(actor) and #MP0.GetActorsByTypes(Artillery) > 3 then
				ArtyBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "86")
				SetTauntPlaying(DateTime.Seconds(5))
			end
		end
	end)
	MP0BaseBuildingsLost = 0
	MP0BaseDefensesLost = 0
	Trigger.OnBuildingPlaced(MP0, function(_, building)
		if not PlayerDamagedTauntPlayed or not RandomTauntsStarted then
			Trigger.OnDamaged(building, function(_, attacker)
				if attacker.Owner == Enemy then
					if not PlayerDamagedTauntPlayed and not TauntPlaying then
						PlayerDamagedTauntPlayed = true
						Taunts.PlayTauntNotification(Enemy, "5")
						SetTauntPlaying(DateTime.Seconds(5))
					end

					if not RandomTauntsStarted then
						RandomTauntsStarted = true
						PlayRandomTaunt()
					end
				end
			end)
		end

		if building.Type == "building.gla_command_center" then
			SetupSupportPowerNotifications(building)
		end
		if IsScudStorm(building) then
			if not ScudBuildTauntPlayed and not TauntPlaying then
				ScudBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "51")
				SetTauntPlaying(DateTime.Seconds(4))
			elseif not SecondScudBuildTauntPlayed and not TauntPlaying and #MP0.GetActorsByTypes(ScudStorm) > 1 then
				SecondScudBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "79")
				SetTauntPlaying(DateTime.Seconds(5))
			end
		end
		if IsAntiAir(building) then
			if not AntiAirTauntPlayed and not TauntPlaying and #MP0.GetActorsByTypes(AntiAir) > 6 then
				AntiAirTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "52")
				SetTauntPlaying(DateTime.Seconds(6))
			elseif not SecondAntiAirTauntPlayed and not TauntPlaying and #MP0.GetActorsByTypes(AntiAir) > 10 then
				SecondAntiAirTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "93")
				SetTauntPlaying(DateTime.Seconds(3))
			end
		end

		if IsBaseDefense(building) then
			if not DefenseKillTauntPlayed then
				Trigger.OnKilled(building, function()
					if not DefenseKillTauntPlayed and not TauntPlaying then
						DefenseKillTauntPlayed = true
						Taunts.PlayTauntNotification(Enemy, "6")
						SetTauntPlaying(DateTime.Seconds(8))
					end
				end)
			end
			if not TooManyDefensesKillTauntPlayed then
				Trigger.OnKilled(building, function()
					MP0BaseDefensesLost = MP0BaseDefensesLost + 1
					if not TooManyDefensesKillTauntPlayed and not TauntPlaying and MP0BaseDefensesLost > 2 then
						TooManyDefensesKillTauntPlayed = true
						Taunts.PlayTauntNotification(Enemy, "24")
						SetTauntPlaying(DateTime.Seconds(3))
					end
				end)
			end
		end
		if not BarrKillTauntPlayed and IsBarracks(building) then
			Trigger.OnKilled(building, function()
				if not BarrKillTauntPlayed and not TauntPlaying and #MP0.GetActorsByTypes(Barracks) == 0 then
					BarrKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "23")
					SetTauntPlaying(DateTime.Seconds(3))
				end
			end)
		end
		if not WFacSWKillTauntPlayed and (IsWarFactory(building) or IsSuperWeapon(building)) then
			Trigger.OnKilled(building, function()
				if not WFacSWKillTauntPlayed and not TauntPlaying then
					WFacSWKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "22")
					SetTauntPlaying(DateTime.Seconds(4))
				end
			end)
		end
		if not AdvBuildKillTauntPlayed and IsAdvancedBuilding(building) then
			Trigger.OnKilled(building, function()
				if not AdvBuildKillTauntPlayed and not TauntPlaying then
					AdvBuildKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "10")
					SetTauntPlaying(DateTime.Seconds(2))
				end
			end)
		end
		if not TooManyBuildingKillTauntPlayed and IsBaseBuilding(building) then
			Trigger.OnKilled(building, function()
				MP0BaseBuildingsLost = MP0BaseBuildingsLost + 1
				if not TooManyBuildingKillTauntPlayed and not TauntPlaying and MP0BaseBuildingsLost > 4 then
					TooManyBuildingKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "25")
					SetTauntPlaying(DateTime.Seconds(7))
				end
			end)
		end
	end)
end
