--[[
   Copyright (c) The OpenRA Developers and Contributors
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

EnemyBase = { EnemyCommandCenter, EnemyBarracks, EnemyAirfield1, EnemyAirfield2, EnemyAirfield3, EnemySupplyCenter, EnemySupplyDrop1, EnemySupplyDrop2, EnemyReactor1, EnemyReactor2, EnemyReactor3, EnemyReactor4, EnemyReactor5, EnemyReactor6, EnemyReactor7, EnemyReactor8, EnemyReactor9, EnemyReactor10, EnemyReactor11, EnemyReactor12, EnemyPatriot1, EnemyPatriot2, EnemyPatriot3, EnemyPatriot4, EnemyPatriot5, EnemyPatriot6, EnemyPatriot7, EnemyPatriot8, EnemyPatriot9, EnemyPatriot10, EnemyPatriot11 }
TauntDerricks = { OilDerrick1, OilDerrick2, OilDerrick3, OilDerrick4, OilDerrick5 }

RandomTaunts = { "5", "7", "8", "9", "13", "14" }

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

ChinookTeams =
{
	{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" },
	{ "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" }
}

InfantryAttackForces =
{
	easy =
	{
		{ "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.missile_defender" },
		{ "infantry.missile_defender", "infantry.missile_defender" }
	},
	normal =
	{
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" }
	},
	hard =
	{
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.ranger" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender" },
		{ "infantry.ranger", "infantry.ranger", "infantry.ranger", "infantry.missile_defender", "infantry.missile_defender" },
		{ "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender", "infantry.missile_defender" }
	}
}

AirAttackForces =
{
	default = {
		easy =
		{
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.comanche" }
		},
		normal =
		{
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.stealth_fighter.air" },
			{ "aircraft.aurora" },
			{ "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche" }
		},
		hard =
		{
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.stealth_fighter.air" },
			{ "aircraft.stealth_fighter.air", "aircraft.stealth_fighter.air" },
			{ "aircraft.aurora" },
			{ "aircraft.aurora", "aircraft.aurora" },
			{ "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche", "aircraft.comanche" }
		}
	},
	merged = {
		easy =
		{
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.comanche" }
		},
		normal =
		{
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.stealth_fighter.air" },
			{ "aircraft.aurora_alpha" },
			{ "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche" }
		},
		hard =
		{
			{ "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor", "aircraft.king_raptor" },
			{ "aircraft.stealth_fighter.air" },
			{ "aircraft.stealth_fighter.air", "aircraft.stealth_fighter.air" },
			{ "aircraft.aurora_alpha" },
			{ "aircraft.aurora_alpha", "aircraft.aurora_alpha" },
			{ "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche" },
			{ "aircraft.comanche", "aircraft.comanche", "aircraft.comanche" }
		}
	}
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
	{ CenterStart, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd2 },
	{ CenterStart, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP3, CenterEnd2 }
}

FlankPaths =
{
	{ FlankStart, FlankWP1, FlankWP2, FlankWP3, FlankWP4, FlankEnd1 }
}

CenterAndBackDoorPaths =
{
	{ CenterStart, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP3, CenterEnd2 },
	{ CenterStart, CenterWP3, CenterEnd1 },
	{ CenterStart, CenterWP3, CenterEnd2 },
	{ BackDoorStart, BackDoorWP1, BackDoorWP2, BackDoorWP3, BackDoorEnd1 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP9, BackDoorWP5, BackDoorWP6, BackDoorWP7, BackDoorWP8, BackDoorEnd2 },
	{ BackDoorStart, BackDoorWP4, BackDoorWP9, BackDoorWP10, BackDoorWP11, BackDoorEnd3 }
}

AllPaths =
{
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
	if factory == nil or factory.IsDead or factory.Owner ~= Enemy then
		return
	end

	local built = factory.Build(Utils.Random(unit_list), function(units)
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
end

InitializeAttackProduction = function(building)
	if building.Type == "building.usa_barracks" then
		BuildAttackForce(InfantryAttackForces[Difficulty], building, function() return FlankPaths end)
	elseif building.Type == "building.usa_airfield" then
		BuildAttackForce(AirAttackForces[AttackForceList][Difficulty], building, function() return EnemyAttackPath end)
	end
end

CurrentGarrisonTeamCount = 0
BuildGarrisonForce = function()
	local validGarrisonables = Utils.Where(GarrisonableBuildings[Difficulty], function(a)
		return a.Owner == Neutral and a.Health > a.MaxHealth * 0.25
	end)
	if #validGarrisonables > 0 then
		TrainGarrisoners(Enemy, Utils.Random(GarrisonTeams[Difficulty]), "building.usa_barracks", validGarrisonables)
		CurrentGarrisonTeamCount = CurrentGarrisonTeamCount + 1
		if CurrentGarrisonTeamCount < MaxGarrisonTeams[Difficulty] then
			Trigger.AfterDelay(DateTime.Minutes(2), function()
				BuildGarrisonForce()
			end)
		end
	else
		Trigger.AfterDelay(DateTime.Minutes(2), function()
			BuildGarrisonForce()
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
	if KilledAirfields == 0 then
		Taunts.PlayTauntNotification(Enemy, "28")
		KilledAirfields = KilledAirfields + 1
	elseif KilledAirfields == 1 then
		Taunts.PlayTauntNotification(Enemy, "72")
		KilledAirfields = KilledAirfields + 1
	elseif KilledAirfields == 2 then
		Taunts.PlayTauntNotification(Enemy, "73")
		KilledAirfields = KilledAirfields + 1
	elseif KilledAirfields == 3 then
		Taunts.PlayTauntNotification(Enemy, "74")
		KilledAirfields = KilledAirfields + 1
	elseif KilledAirfields == 4 then
		Taunts.PlayTauntNotification(Enemy, "37")
		KilledAirfields = KilledAirfields + 1
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

		if (RandomTauntToPlay == 7) then
			RandomTauntToPlay = 1
		else
			RandomTauntToPlay = RandomTauntToPlay + 1
		end
	end

	if 301 > MP0.Cash and not LowCashTauntPlayed then
		LowCashTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "48")
	end

	if MP0.PowerState == "Low" or MP0.PowerState == "Critical" then
		if not LowPowerTaunt1Played then
			LowPowerTaunt1Played = true
			Taunts.PlayTauntNotification(Enemy, "46")
		end

		if not LowPowerTaunt2Played and PlayerRecoveredFromFirstLowPower then
			LowPowerTaunt2Played = true
			Taunts.PlayTauntNotification(Enemy, "47")
		end
	end

	if LowPowerTaunt1Played then
		LowPowerTauntTimer = LowPowerTauntTimer + 1
		if MP0.PowerState == "Normal" and 1501 < LowPowerTauntTimer then
			PlayerRecoveredFromFirstLowPower = true
		end
	end

	if Enemy.PowerState == "Low" or Enemy.PowerState == "Critical" then
		if not EnemyLowPowerTauntPlayed then
			EnemyLowPowerTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "49")
		end
	end

	if not RangerBuildTauntPlayed and #MP0.GetActorsByType("infantry.ranger") > 9 then
		RangerBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "81")
	end
	if not DefeBuildTauntPlayed and #MP0.GetActorsByTypes(BaseDefense) > 5 then
		DefeBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "52")
	end
	if not DozerBuildTauntPlayed and #MP0.GetActorsByTypes(Dozer) > 4 then
		DozerBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "3")
	end
	if not TankBuildTauntPlayed and #MP0.GetActorsByTypes(Tank) > 5 then
		TankBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "53")
	end
	if not ArtyBuildTauntPlayed and #MP0.GetActorsByTypes(Artillery) > 5 then
		ArtyBuildTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "86")
	end
	if not GarrisonTauntPlayed and #MP0.GetActorsByTypes(CivilianBuilding) > 5 then
		GarrisonTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "55")
	end

	if not EnemyPlaneTauntPlayed and #MP0.GetActorsByTypes(Plane) > 9 then
		EnemyPlaneTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "51")
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

	EnemyAttackPath = CenterPaths
	Trigger.AfterDelay(InitialAttackDelay[Difficulty], function()
		ProductionBegun = true
		Utils.Do(Enemy.GetActorsByTypes({"building.usa_barracks", "building.usa_airfield"}), function(building)
			InitializeAttackProduction(building)
		end)

		Taunts.PlayTauntNotification(Enemy, "70")
	end)
	Trigger.AfterDelay(InitialAttackDelay[Difficulty] / 2, function()
		BuildGarrisonForce()
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
	Utils.Do(TauntDerricks, function(oild)
		Trigger.OnCapture(oild, function(_, _, _, newOwner)
			if not OildBuildTauntPlayed and newOwner == MP0 then
				OildBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "33")
			end
		end)
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(CommandCenter), function()
		Taunts.PlayTauntNotification(Enemy, "11")
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(BaseDefense), function()
		Taunts.PlayTauntNotification(Enemy, "29")
	end)
	Utils.Do(Enemy.GetActorsByTypes(Airfield), function(airf)
		Trigger.OnKilledOrCaptured(airf, function()
			PlayAirfieldKilledTaunt()
		end)
	end)
	Trigger.OnSuperWeaponActivated(EnemyCommandCenter, function(_, orderName)
		if not ParadropTauntPlayed and orderName == "ParadropPowerInfoOrder" then
			ParadropTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "71")
		end
		if not FABTauntPlayed and orderName == "FuelAirBombPowerInfoOrder" then
			FABTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "82")
		end
		if not A10TauntPlayed and orderName == "A10PowerInfoOrder" then
			A10TauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "84")
		end
	end)

	Trigger.OnAnyProduction(function(_, actor)
		if actor.Type == "aircraft.combat_chinook" and actor.Owner == Enemy then
			BuildCombatChinookForce(actor, ChinookTeams, Utils.Random(Enemy.GetActorsByType("building.usa_barracks")), function() return FlankPaths end)
		end

		-- No ownership check; but the AI general can't/doesn't build these.
		if not BurtonBuildTauntPlayed and actor.Type == "infantry.colonel_burton" then
			BurtonBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "83")
		end
		if not ScudLauncherBuildTauntPlayed and actor.Type == "vehicle.scud_launcher" then
			ScudLauncherBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "87")
		end
	end)
	Trigger.OnBuildingPlaced(MP0, function(_, building)
		if IsWarFactory(building) then
			PlayerBuiltWarFactory = true
		end

		if IsScudStorm(building) then
			if not ScudBuildTauntPlayed then
				ScudBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "51")
			elseif not SecondScudBuildTauntPlayed and #MP0.GetActorsByTypes(ScudStorm) > 1 then
				SecondScudBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "79")
			end
		end

		if not BarrKillTauntPlayed and IsBarracks(building) then
			Trigger.OnKilled(building, function()
				if not BarrKillTauntPlayed and #MP0.GetActorsByTypes(Barracks) == 0 then
					BarrKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "23")
				end
			end)
		end
		if not DefenseKillTauntPlayed and IsBaseDefense(building) then
			Trigger.OnKilled(building, function()
				if not DefenseKillTauntPlayed then
					DefenseKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "6")
				end
			end)
		end
		if not WFacSWKillTauntPlayed and (IsWarFactory(building) or IsSuperWeapon(building)) then
			Trigger.OnKilled(building, function()
				if not WFacSWKillTauntPlayed then
					WFacSWKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "22")
				end
			end)
		end
		if not AdvBuildKillTauntPlayed and IsAdvancedBuilding(building) then
			Trigger.OnKilled(building, function()
				if not AdvBuildKillTauntPlayed then
					AdvBuildKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "10")
				end
			end)
		end
	end)
end
