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

CaptureActor = {
	default = "infantry.red_guard",
	merged = "infantry.minigunner"
}
TechToCapture = {
	easy = { OilDerrick1, OilDerrick2 },
	normal = { OilDerrick1, OilDerrick2, ArtilleryPlatform },
	hard = { OilDerrick1, OilDerrick2, ArtilleryPlatform, RepairBay }
}

GarrisonableBuildings = {
	easy = { Church, BigHouse1, BigHouse2, BigHouse3, MediumHouse1, SmallHouse1, SmallHouse2 },
	normal = { Church, BigHouse1, BigHouse2, BigHouse3, BigHouse4, BigHouseArty, MediumHouse1, SmallHouse1, SmallHouse2 },
	hard = { Church, BigHouse1, BigHouse2, BigHouse3, BigHouse4, BigHouseArty, MediumHouse1 }
}
MaxGarrisonTeams = {
	easy = 1,
	normal = 2,
	hard = 3
}
GarrisonTeams = {
	default = {
		easy = {
			{ "infantry.red_guard", "infantry.red_guard", "infantry.tank_hunter", "infantry.tank_hunter" }
		},
		normal = {
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" }
		},
		hard = {
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
		}
	},
	merged = {
		easy = {
			{ "infantry.minigunner", "minigunner", "infantry.tank_hunter", "infantry.tank_hunter" }
		},
		normal = {
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" }
		},
		hard = {
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
		}
	}
}

DefenseTeams = {
	default = {
		easy = {
			{ "vehicle.battlemaster_tank" },
			{ "vehicle.battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank" }
		},
		normal = {
			{ "vehicle.battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.gatling_tank" }
		},
		hard = {
			{ "vehicle.battlemaster_tank","vehicle.battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.battlemaster_tank","vehicle.battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank" }
		}
	},
	merged = {
		easy = {
			{ "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank" }
		},
		normal = {
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank" }
		},
		hard = {
			{ "vehicle.nuclear_battlemaster_tank","vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.nuclear_battlemaster_tank","vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank" }
		}
	}
}

InfantryAttackForces =
{
	default = {
		easy = {
			{ "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.tank_hunter" },
			{ "infantry.tank_hunter" }
		},
		normal = {
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter" }
		},
		hard = {
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard", "infantry.red_guard" },
			{ "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" }
		}
	},
	merged = {
		easy = {
			{ "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.tank_hunter" },
			{ "infantry.tank_hunter" }
		},
		normal = {
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter" }
		},
		hard = {
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner", "infantry.minigunner" },
			{ "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" },
			{ "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter", "infantry.tank_hunter" }
		}
	}
}

VehicleAttackForces = {
	default = {
		easy = {
			{ "vehicle.battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.troop_crawler" }
		},
		normal = {
			{ "vehicle.battlemaster_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.troop_crawler" },
			{ "vehicle.troop_crawler", "vehicle.troop_crawler" },
			{ "vehicle.dragon_tank" },
			{ "vehicle.emparor_overlord" },
			{ "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.ecm_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.ecm_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank" },
		},
		hard = {
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.battlemaster_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.troop_crawler" },
			{ "vehicle.troop_crawler", "vehicle.troop_crawler" },
			{ "vehicle.troop_crawler", "vehicle.troop_crawler", "vehicle.troop_crawler" },
			{ "vehicle.dragon_tank" },
			{ "vehicle.dragon_tank", "vehicle.dragon_tank" },
			{ "vehicle.emparor_overlord" },
			{ "vehicle.emparor_overlord", "vehicle.emparor_overlord" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank", "vehicle.ecm_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank", "vehicle.ecm_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank", "vehicle.ecm_tank" },
			{ "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank", "vehicle.ecm_tank" },
		}
	},
	merged = {
		easy = {
			{ "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.assault_troop_crawler" }
		},
		normal = {
			{ "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.assault_troop_crawler" },
			{ "vehicle.assault_troop_crawler", "vehicle.assault_troop_crawler" },
			{ "vehicle.dragon_tank" },
			{ "vehicle.emparor_overlord" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.ecm_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.ecm_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank" },
		},
		hard = {
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank" },
			{ "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.gatling_tank" },
			{ "vehicle.assault_troop_crawler" },
			{ "vehicle.assault_troop_crawler", "vehicle.assault_troop_crawler" },
			{ "vehicle.assault_troop_crawler", "vehicle.assault_troop_crawler", "vehicle.assault_troop_crawler" },
			{ "vehicle.dragon_tank" },
			{ "vehicle.dragon_tank", "vehicle.dragon_tank" },
			{ "vehicle.emparor_overlord" },
			{ "vehicle.emparor_overlord", "vehicle.emparor_overlord" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank", "vehicle.ecm_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank", "vehicle.ecm_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank", "vehicle.ecm_tank" },
			{ "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.nuclear_battlemaster_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.gatling_tank", "vehicle.ecm_tank", "vehicle.ecm_tank" },
		}
	}
}

AirAttackForces = {
	default = {
		easy = {
			{ "aircraft.mig" }
		},
		normal = {
			{ "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig" },
			{ "aircraft.helix" }
		},
		hard = {
			{ "aircraft.mig", "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig", "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig", "aircraft.mig", "aircraft.mig" },
			{ "aircraft.helix" },
			{ "aircraft.helix", "aircraft.helix" }
		}
	},
	merged = {
		easy = {
			{ "aircraft.mig" }
		},
		normal = {
			{ "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig" },
			{ "aircraft.assault_helix" }
		},
		hard = {
			{ "aircraft.mig", "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig", "aircraft.mig" },
			{ "aircraft.mig", "aircraft.mig", "aircraft.mig", "aircraft.mig" },
			{ "aircraft.assault_helix" },
			{ "aircraft.assault_helix", "aircraft.assault_helix" }
		}
	}
}

HackerCount = {
	easy = 2,
	normal = 4,
	hard = 4
}

InitialAttackDelay = {
	easy = DateTime.Minutes(3),
	normal = DateTime.Minutes(2),
	hard = DateTime.Minutes(1)
}

AirInitialAttackDelay = {
	easy = DateTime.Minutes(9),
	normal = DateTime.Minutes(7),
	hard = DateTime.Minutes(5)
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
	{ CenterStart, CenterWP1, CenterWP2, CenterWP4, CenterWP5, CenterWP9, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP4, CenterWP5, CenterWP9, CenterEnd1 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP10, CenterEnd2 },
	{ CenterStart, CenterWP1, CenterWP2, CenterWP6, CenterWP7, CenterWP8, CenterEnd3 },
	{ CenterStart, CenterWP1, CenterWP3, CenterWP11, CenterWP7, CenterWP8, CenterEnd3 }
}

CenterAndBackDoorPaths = {
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

AllPaths = {
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
		if IsOverlordTank(unit) then
			unit.Build({"upgrade.overlord_gatling"})
		end
		if IsHelix(unit) then
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

InitializeAttackProduction = function(building)
	if building.Type == "building.prc_barracks" then
		BuildAttackForce(InfantryAttackForces[AttackForceList][Difficulty], building, function() return EnemyAttackPath end)
	elseif building.Type == "building.prc_war_factory" then
		BuildAttackForce(VehicleAttackForces[AttackForceList][Difficulty], building, function() return EnemyAttackPath end)
	elseif building.Type == "building.prc_airfield" then
		BuildAttackForce(AirAttackForces[AttackForceList][Difficulty], building, function() return EnemyAttackPath end)
	end
end

CurrentGarrisonTeamCount = 0
BuildGarrisonForce = function(producer)
	local validGarrisonables = Utils.Where(GarrisonableBuildings[Difficulty], function(a)
		return a.Owner == Neutral and a.Health > a.MaxHealth * 0.25
	end)
	if #validGarrisonables > 0 then
		TrainGarrisoners(Enemy, Utils.Random(GarrisonTeams[AttackForceList][Difficulty]), producer, validGarrisonables)
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

		PlayerSupplyDock.SupplyAmount = 80000
	end

	if Difficulty == "normal" then
		Enemy.Cash = Enemy.Cash + ((Enemy.Cash * 17) / 13)
		Enemy.GrantCondition("difficulty-normal")
	end

	if Difficulty == "hard" then
		MP0.Cash = MP0.Cash - ((MP0.Cash * 3) / 13)
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

	TrainStaticDefense(Enemy, DefenseTeams[AttackForceList][Difficulty][1], "building.prc_war_factory", GuardNorth.Location)
	TrainStaticDefense(Enemy, DefenseTeams[AttackForceList][Difficulty][2], "building.prc_war_factory", GuardSouth.Location)
	TrainStaticDefense(Enemy, DefenseTeams[AttackForceList][Difficulty][3], "building.prc_war_factory", GuardMiddleNorth.Location)
	TrainStaticDefense(Enemy, DefenseTeams[AttackForceList][Difficulty][4], "building.prc_war_factory", GuardMiddleSouth.Location)
end

KilledWarFactories = 0
PlayWFacKilledTaunt = function()
	if KilledWarFactories == 0 then
		Taunts.PlayTauntNotification(Enemy, "14")
		KilledWarFactories = KilledWarFactories + 1
	elseif KilledWarFactories == 1 then
		Taunts.PlayTauntNotification(Enemy, "40")
		KilledWarFactories = KilledWarFactories + 1
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
	if 301 > Enemy.Cash and not EnemyLowCashTauntPlayed then
		EnemyLowCashTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "62")
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

	if not GarrisonTauntPlayed and #MP0.GetActorsByTypes(CivilianBuilding) > 0 then
		GarrisonTauntPlayed = true
		Taunts.PlayTauntNotification(Enemy, "74")
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

		Taunts.PlayTauntNotification(Enemy, "99")
	end)

	Trigger.OnBuildingPlaced(Enemy, function(_, building)
		table.insert(EnemyBase, building)

		if ProductionBegun then
			InitializeAttackProduction(building)
		end
		if building.Type == "building.prc_war_factory" then
			Trigger.OnKilledOrCaptured(building, function()
				PlayWFacKilledTaunt()
			end)
		end
	end)

	Trigger.AfterDelay(BackDoorAttackDelay[Difficulty], function()
		EnemyAttackPath = CenterAndBackDoorPaths
	end)
	Trigger.AfterDelay(FlankAttackDelay[Difficulty], function()
		EnemyAttackPath = AllPaths
	end)

	Taunts.PlayTauntNotification(Enemy, "21")
	Utils.Do(Neutral.GetActorsByTypes(TechBuilding), function(building)
		Trigger.OnKilled(building, function()
			if building.Owner == MP0 and not TechKillTauntPlayed then
				TechKillTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "31")
			elseif building.Owner == Enemy and not EnemyTechKillTauntPlayed then
				EnemyTechKillTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "38")
			end
		end)
	end)
	Utils.Do(Neutral.GetActorsByType("tech.oil_derrick"), function(oild)
		Trigger.OnCapture(oild, function(_, _, _, newOwner)
			if not OildBuildTauntPlayed and newOwner == MP0 then
				OildBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "48")
			end
		end)
	end)
	Utils.Do(Neutral.GetActorsByType("tech.artillery_platform"), function(artp)
		Trigger.OnCapture(artp, function(_, _, _, newOwner)
			if not ArtyPlatformBuildTauntPlayed and newOwner == MP0 then
				ArtyPlatformBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "49")
			end
		end)
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(CommandCenter), function()
		Taunts.PlayTauntNotification(Enemy, "44")
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(Barracks), function()
		Taunts.PlayTauntNotification(Enemy, "39")
	end)
	Utils.Do(Enemy.GetActorsByTypes(WarFactory), function(wfac)
		Trigger.OnKilledOrCaptured(wfac, function()
			PlayWFacKilledTaunt()
		end)
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(Airfield), function()
		Taunts.PlayTauntNotification(Enemy, "41")
	end)
	Trigger.OnAnyKilled(Enemy.GetActorsByTypes(BaseDefense), function()
		Taunts.PlayTauntNotification(Enemy, "42")
	end)

	Trigger.OnAnyProduction(function(_, actor)
		if actor.Owner == Enemy then
			if IsHacker(actor) and not HackersBuilt then
				-- GetActorsByTypes() doesn't return the hackers in the Internet Center. Count them separately.
				local internetCenterHackers = 0
				local internetCenters = Enemy.GetActorsByType("building.internet_center")
				if #internetCenters > 0 then
					Utils.Do(internetCenters, function(internetCenter)
						internetCenterHackers = internetCenterHackers + internetCenter.PassengerCount
					end)
				end

				if (#Enemy.GetActorsByTypes(Hacker) + internetCenterHackers >= HackerCount[Difficulty] * 2) then
					HackersBuilt = true

					if ProductionBegun then
						BuildAttackForce(InfantryAttackForces[AttackForceList][Difficulty], EnemyBarracks, function() return EnemyAttackPath end)
					end
					if #Enemy.GetActorsByType("upgrade.capture_building") > 0 then
						CaptureTechBuildings(TechToCapture[Difficulty], "building.prc_barracks", CaptureActor[AttackForceList])
					end
					Trigger.AfterDelay(InitialAttackDelay[Difficulty] / 2, function()
						BuildGarrisonForce("building.prc_barracks")
					end)
				end
			end
			if actor.Type == "upgrade.capture_building" then
				if HackersBuilt then
					CaptureTechBuildings(TechToCapture[Difficulty], "building.prc_barracks", CaptureActor[AttackForceList])
				end
			end
		end

		if actor.Owner == MP0 then
			if not InfaBuildTauntPlayed and IsInfantry(actor) and #MP0.GetActorsByTypes(Infantry) > 12 then
				InfaBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "67")
			end
			if not TankBuildTauntPlayed and IsTank(actor) and #MP0.GetActorsByTypes(Tank) > 6 then
				TankBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "69")
			end
			if not PlaneBuildTauntPlayed and IsPlane(actor) and #MP0.GetActorsByTypes(Plane) > 4 then
				PlaneBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "68")
			end
			if not BurtonBuildTauntPlayed and IsBurton(actor) then
				BurtonBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "75")
			end
			if not JarmenBuildTauntPlayed and IsJarmen(actor) then
				JarmenBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "77")
			end
			if not LotusBuildTauntPlayed and IsLotus(actor) then
				LotusBuildTauntPlayed = true
				Taunts.PlayTauntNotification(Enemy, "76")
			end
		end
	end)
	Trigger.OnKilled(MP0.GetActorsByTypes(CommandCenter)[1], function()
		if not CommandCenterKillTauntPlayed then
			CommandCenterKillTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "36")
		end
	end)

	Trigger.OnBuildingPlaced(MP0, function(_, building)
		if not BaseBuildingBuildTauntPlayed and IsBaseBuilding(building) and #MP0.GetActorsByTypes(BaseBuilding) > 7 then
			BaseBuildingBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "70")
		end
		if not DefenseBuildTauntPlayed and IsBaseDefense(building) and #MP0.GetActorsByTypes(BaseDefense) > 5 then
			DefenseBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "66")
		end
		if not BarrBuildTauntPlayed and IsBarracks(building) then
			BarrBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "80")
		end
		if not WFacBuildTauntPlayed and IsWarFactory(building) then
			WFacBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "79")
		end
		if not AirfBuildTauntPlayed and IsAirfield(building) then
			AirfBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "79")
		end
		if not PCanBuildTauntPlayed and IsParticleCannon(building) then
			PCanBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "65")

			Trigger.OnSupportPowerActivated(building, function()
				if not PCanFireTauntPlayed then
					PCanFireTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "73")
				end
			end)
		end
		if not ScudBuildTauntPlayed and IsScudStorm(building) then
			ScudBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "63")

			Trigger.OnSupportPowerActivated(building, function()
				if not ScudFireTauntPlayed then
					ScudFireTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "71")
				end
			end)
		end
		if not NukeBuildTauntPlayed and IsMissileSilo(building) then
			NukeBuildTauntPlayed = true
			Taunts.PlayTauntNotification(Enemy, "64")

			Trigger.OnSupportPowerActivated(building, function()
				if not NukeFireTauntPlayed then
					NukeFireTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "72")
				end
			end)
		end

		if not CommandCenterKillTauntPlayed and IsCommandCenter(building) then
			Trigger.OnKilled(building, function()
				if not CommandCenterKillTauntPlayed then
					CommandCenterKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "36")
				end
			end)
		end
		if not DefenseKillTauntPlayed and IsBaseDefense(building) then
			Trigger.OnKilled(building, function()
				if not DefenseKillTauntPlayed then
					DefenseKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "35")
				end
			end)
		end
		if not BarrKillTauntPlayed and IsBarracks(building) then
			Trigger.OnKilled(building, function()
				if not BarrKillTauntPlayed and #MP0.GetActorsByTypes(Barracks) == 0 then
					BarrKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "32")
				end
			end)
		end
		if not WFacKillTauntPlayed and IsWarFactory(building) then
			Trigger.OnKilled(building, function()
				if not WFacKillTauntPlayed then
					WFacKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "33")
				end
			end)
		end
		if not AirfieldKillTauntPlayed and IsWarFactory(building) then
			Trigger.OnKilled(building, function()
				if not AirfieldKillTauntPlayed then
					AirfieldKillTauntPlayed = true
					Taunts.PlayTauntNotification(Enemy, "34")
				end
			end)
		end
	end)
end
