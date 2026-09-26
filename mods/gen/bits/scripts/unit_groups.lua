--[[
   Copyright (c) The OpenRA Developers and Contributors
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

CommandCenter = {
	"building.usa_command_center",
	"building.gla_command_center",
	"building.prc_command_center",
	"building.prc_command_center.radar",
	"fake.command_center"
}
IsCommandCenter = function(actor)
	return
		actor.Type == "building.usa_command_center" or
		actor.Type == "building.gla_command_center" or
		actor.Type == "building.prc_command_center" or
		actor.Type == "building.prc_command_center.radar" or
		actor.Type == "fake.command_center"
end

PowerPlant = {
	"building.cold_fusion_reactor",
	"building.cold_fusion_reactor.laser",
	"building.advanced_cold_fusion_reactor",
	"building.nuclear_reactor",
	"building.advanced_nuclear_reactor"
}
IsPowerPlant = function(actor)
	return
		actor.Type == "building.cold_fusion_reactor" or
		actor.Type == "building.cold_fusion_reactor.laser" or
		actor.Type == "building.advanced_cold_fusion_reactor" or
		actor.Type == "building.nuclear_reactor" or
		actor.Type == "building.advanced_nuclear_reactor"
end

SupplyCenter = {
	"building.usa_supply_center",
	"building.gla_supply_stash",
	"building.prc_supply_center",
	"fake.supply_stash"
}
IsSupplyCenter = function(actor)
	return
		actor.Type == "building.usa_supply_center" or
		actor.Type == "building.gla_supply_stash" or
		actor.Type == "building.prc_supply_center" or
		actor.Type == "fake.supply_stash"
end

Barracks = {
	"building.usa_barracks",
	"building.gla_barracks",
	"building.prc_barracks",
	"fake.barracks"
}
IsBarracks = function(actor)
	return
		actor.Type == "building.usa_barracks" or
		actor.Type == "building.gla_barracks" or
		actor.Type == "building.prc_barracks" or
		actor.Type == "fake.barracks"
end

WarFactory = {
	"building.usa_war_factory",
	"building.arms_dealer",
	"building.prc_war_factory",
	"fake.arms_dealer"
}
IsWarFactory = function(actor)
	return
		actor.Type == "building.usa_war_factory" or
		actor.Type == "building.arms_dealer" or
		actor.Type == "building.prc_war_factory" or
		actor.Type == "fake.arms_dealer"
end

Airfield = {
	"building.usa_airfield",
	"building.prc_airfield"
}
IsAirfield = function(actor)
	return
		actor.Type == "building.usa_airfield" or
		actor.Type == "building.prc_airfield"
end

AdvancedBuilding = {
	"building.strategy_center",
	"building.palace",
	"building.propaganda_center",
	"fake.palace"
}
IsAdvancedBuilding = function(actor)
	return
		actor.Type == "building.strategy_center" or
		actor.Type == "building.palace" or
		actor.Type == "building.propaganda_center" or
		actor.Type == "fake.palace"
end

ParticleCannon = {
	"building.particle_cannon",
	"building.particle_cannon.super"
}
IsParticleCannon = function(actor)
	return
		actor.Type == "building.particle_cannon" or
		actor.Type == "building.particle_cannon.super"
end

ScudStorm = {
	"building.scud_storm",
	"building.scud_storm.boss",
	"fake.scud_storm"
}
IsScudStorm = function(actor)
	return
		actor.Type == "building.scud_storm" or
		actor.Type == "building.scud_storm.boss" or
		actor.Type == "fake.scud_storm"
end

MissileSilo = {
	"building.missile_silo"
}
IsMissileSilo = function(actor)
	return actor.Type == "building.missile_silo"
end

SuperWeapon = Utils.Concat(Utils.Concat(ParticleCannon, ScudStorm), MissileSilo)
IsSuperWeapon = function(actor)
	return
		IsParticleCannon(actor) or
		IsScudStorm(actor) or
		IsMissileSilo(actor)
end

BaseBuilding = Utils.Concat(Utils.Concat(Utils.Concat(Utils.Concat(Utils.Concat(Utils.Concat(
	CommandCenter, PowerPlant), SupplyCenter), Barracks), WarFactory), AdvancedBuilding), {
	"building.detention_camp",
	"building.supply_drop_zone",
	"building.black_market",
	"building.internet_center",
	"fake.black_market"
})
IsBaseBuilding = function(actor)
	return
		IsCommandCenter(actor) or
		IsPowerPlant(actor) or
		IsSupplyCenter(actor) or
		IsBarracks(actor) or
		IsWarFactory(actor) or
		IsAdvancedBuilding(actor) or
		actor.Type == "building.detention_camp" or
		actor.Type == "building.supply_drop_zone" or
		actor.Type == "building.black_market" or
		actor.Type == "building.internet_center" or
		actor.Type == "fake.black_market"
end

BaseDefense = {
	"building.patriot",
	"building.emp_patriot",
	"building.laser_turret",
	"building.firebase",
	"building.tunnel_network",
	"building.tunnel_network.no_free_actor",
	"building.toxin_tunnel_network",
	"building.toxin_tunnel_network.no_free_actor",
	"building.stinger_site",
	"building.gatling_cannon",
	"building.bunker",
	"building.fortified_bunker",
	"fake.tunnel_network",
	"fake.toxin_tunnel_network",
	"fake.stinger_site"
}
IsBaseDefense = function(actor)
	return
		actor.Type == "building.patriot" or
		actor.Type == "building.emp_patriot" or
		actor.Type == "building.laser_turret" or
		actor.Type == "building.firebase" or
		actor.Type == "building.tunnel_network" or
		actor.Type == "building.tunnel_network.no_free_actor" or
		actor.Type == "building.toxin_tunnel_network" or
		actor.Type == "building.toxin_tunnel_network.no_free_actor" or
		actor.Type == "building.stinger_site" or
		actor.Type == "building.gatling_cannon" or
		actor.Type == "building.bunker" or
		actor.Type == "building.fortified_bunker" or
		actor.Type == "fake.tunnel_network" or
		actor.Type == "fake.toxin_tunnel_network" or
		actor.Type == "fake.stinger_site"
end

Infantry = {
	"infantry.ranger",
	"infantry.missile_defender",
	"infantry.pathfinder",
	"infantry.rebel",
	"infantry.toxin_rebel",
	"infantry.rpg_trooper",
	"infantry.terrorist",
	"infantry.toxin_terrorist",
	"infantry.angry_mob",
	"infantry.hijacker",
	"infantry.saboteur",
	"infantry.red_guard",
	"infantry.minigunner",
	"infantry.tank_hunter",
	"infantry.hacker",
	"infantry.super_hacker",
	"infantry.conscript",
	"infantry.grenadier",
	"infantry.flamethrower"
}
IsInfantry = function(actor)
	return
		actor.Type == "vehicle.ranger" or
		actor.Type == "vehicle.missile_defender" or
		actor.Type == "vehicle.pathfinder" or
		actor.Type == "vehicle.rebel" or
		actor.Type == "vehicle.toxin_rebel" or
		actor.Type == "vehicle.rpg_trooper" or
		actor.Type == "vehicle.toxin_terrorist" or
		actor.Type == "vehicle.angry_mob" or
		actor.Type == "vehicle.hijacker" or
		actor.Type == "vehicle.saboteur" or
		actor.Type == "vehicle.minigunner" or
		actor.Type == "vehicle.tank_hunter" or
		IsHacker(actor) or
		actor.Type == "vehicle.conscript" or
		actor.Type == "vehicle.grenadier" or
		actor.Type == "vehicle.flamethrower"
end

Tank = {
	"vehicle.crusader_tank",
	"vehicle.paladin_tank",
	"vehicle.scorpion_tank",
	"vehicle.marauder_tank",
	"vehicle.battlemaster_tank",
	"vehicle.nuclear_battlemaster_tank",
	"vehicle.overlord_tank",
	"vehicle.emparor_overlord"
}
IsTank = function(actor)
	return
		actor.Type == "vehicle.crusader_tank" or
		actor.Type == "vehicle.paladin_tank" or
		actor.Type == "vehicle.scorpion_tank" or
		actor.Type == "vehicle.marauder_tank" or
		actor.Type == "vehicle.battlemaster_tank" or
		actor.Type == "vehicle.nuclear_battlemaster_tank" or
		actor.Type == "vehicle.overlord_tank" or
		actor.Type == "vehicle.emparor_overlord"
end

Artillery = {
	"vehicle.tomahawk_launcher",
	"vehicle.rocket_buggy",
	"vehicle.scud_launcher",
	"vehicle.inferno_cannon",
	"vehicle.nuke_cannon"
}
IsArtillery = function(actor)
	return
		actor.Type == "vehicle.tomahawk_launcher" or
		actor.Type == "vehicle.rocket_buggy" or
		actor.Type == "vehicle.scud_launcher" or
		actor.Type == "vehicle.inferno_cannon" or
		actor.Type == "vehicle.nuke_cannon"
end

Dozer = {
	"vehicle.usa_mcc",
	"vehicle.gla_mcc",
	"vehicle.prc_mcc",
	"vehicle.tech_mcc"
}
IsDozer = function(actor)
	return
		actor.Type == "vehicle.usa_mcc" or
		actor.Type == "vehicle.gla_mcc" or
		actor.Type == "vehicle.prc_mcc" or
		actor.Type == "vehicle.tech_mcc"
end

Aurora = {
	"aircraft.aurora",
	"aircraft.aurora_alpha"
}
IsAurora = function(actor)
	return
		actor.Type == "aircraft.aurora" or
		actor.Type == "aircraft.aurora_alpha"
end

Plane = Utils.Concat(Aurora, {
	"aircraft.raptor",
	"aircraft.king_raptor",
	"aircraft.stealth_fighter",
	"aircraft.mig"
})
IsPlane = function(actor)
	return
		actor.Type == "aircraft.raptor" or
		actor.Type == "aircraft.king_raptor" or
		actor.Type == "aircraft.stealth_fighter" or
		IsAurora(actor) or
		actor.Type == "aircraft.mig"
end

Helix = {
	"aircraft.helix",
	"aircraft.assault_helix"
}
IsHelix = function(actor)
	return
		actor.Type == "aircraft.helix" or
		actor.Type == "aircraft.assault_helix"
end

Chinook = {
	"aircraft.chinook",
	"aircraft.combat_chinook"
}
IsChinook = function(actor)
	return
		actor.Type == "aircraft.chinook" or
		actor.Type == "aircraft.combat_chinook"
end

Helicopter = Utils.Concat(Helix, Utils.Concat(Chinook, {"aircraft.comanche"}))
IsHelicopter = function(actor)
	return
		IsHelix(actor) or
		actor.Type == "aircraft.comanche" or
		IsChinook(actor)
end

Aircraft = Utils.Concat(Plane, Helicopter)
IsAircraft = function(actor)
	return
		IsPlane(actor) or
		IsHelicopter(actor)
end

Hacker = {
	"infantry.hacker",
	"infantry.super_hacker",
}
IsHacker = function(actor)
	return
		actor.Type == "infantry.hacker" or
		actor.Type == "infantry.super_hacker"
end

Burton = {
	"infantry.colonel_burton",
}
IsBurton = function(actor)
	return actor.Type == "infantry.colonel_burton"
end

Jarmen = {
	"infantry.jarmen_kell",
	"infantry.jarmen_kell.demo",
}
IsJarmen = function(actor)
	return
		actor.Type == "infantry.jarmen_kell" or
		actor.Type == "infantry.jarmen_kell.demo"
end

Lotus = {
	"infantry.black_lotus",
	"infantry.super_lotus"
}
IsLotus = function(actor)
	return
		actor.Type == "infantry.black_lotus" or
		actor.Type == "infantry.super_lotus"
end

OverlordTank = {
	"vehicle.overlord_tank",
	"vehicle.emparor_overlord"
}
IsOverlordTank = function(actor)
	return
		actor.Type == "vehicle.overlord_tank" or
		actor.Type == "vehicle.emparor_overlord"
end

SupplyCollector = Utils.Concat(Chinook, {
	"infantry.worker",
	"vehicle.supply_truck"
})
IsSupplyCollector = function(actor)
	return
		IsChinook(actor) or
		actor.Type == "infantry.worker" or
		actor.Type == "vehicle.supply_truck"
end

AntiAir = {
	"building.patriot",
	"building.emp_patriot",
	"building.laser_turret",
	"building.stinger_site",
	"building.gatling_cannon",
	"infantry.minigunner",
	"infantry.rpg_trooper",
	"infantry.missile_defender",
	"infantry.tank_hunter",
	"vehicle.avenger",
	"vehicle.quad_cannon",
	"vehicle.gatling_tank"
}
IsAntiAir = function(actor)
	return
		actor.Type == "building.patriot" or
		actor.Type == "building.emp_patriot" or
		actor.Type == "building.laser_turret" or
		actor.Type == "building.stinger_site" or
		actor.Type == "building.gatling_cannon" or
		actor.Type == "infantry.minigunner" or
		actor.Type == "infantry.rpg_trooper" or
		actor.Type == "infantry.missile_defender" or
		actor.Type == "infantry.tank_hunter" or
		actor.Type == "vehicle.gatling_tank"
end

TechBuilding = {
	"tech.oil_derrick",
	"tech.oil_refinery",
	"tech.hospital",
	"tech.power_plant",
	"tech.reinforcements_pad",
	"tech.artillery_platform",
	"tech.soviet_barracks",
	"tech.shipyard",
	"tech.repair_bay",
	"tech.communications_center"
}

CivilianBuilding = {
	"v01",
	"v01.snow",
	"v25",
	"v02",
	"v02.snow",
	"v20",
	"v03",
	"v03.snow",
	"v21",
	"v04",
	"v04.snow",
	"v24",
	"v05",
	"v05.snow",
	"v26",
	"v06",
	"v06.snow",
	"v22",
	"v07",
	"v07.snow",
	"v30",
	"v08",
	"v08.snow",
	"v29",
	"v09",
	"v09.snow",
	"v28",
	"v10",
	"v10.snow",
	"v27",
	"v11",
	"v11.snow",
	"v31",
	"v32",
	"v33",
	"v34",
	"v35",
	"v36",
	"v37",
	"rushouse",
	"asianhut",
	"snowhut",
	"lhus",
	"windmill"
}
