--[[
   Copyright (c) The OpenRA Developers and Contributors
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

BaseBuilding =
{
	"building.usa_command_center",
	"building.gla_command_center",
	"building.prc_command_center",
	"building.prc_command_center.radar",
	"fake.command_center",
	"building.advanced_cold_fusion_reactor",
	"building.cold_fusion_reactor",
	"building.cold_fusion_reactor.laser",
	"building.nuclear_reactor",
	"building.advanced_nuclear_reactor",
	"building.usa_supply_center",
	"building.gla_supply_stash",
	"building.prc_supply_center",
	"fake.supply_stash",
	"building.usa_barracks",
	"building.gla_barracks",
	"building.prc_barracks",
	"fake.barracks",
	"building.usa_war_factory",
	"building.arms_dealer",
	"building.prc_war_factory",
	"fake.arms_dealer",
	"building.usa_airfield",
	"building.prc_airfield",
	"building.strategy_center",
	"building.palace",
	"building.propaganda_center",
	"fake.palace",
	"building.detention_camp",
	"building.supply_drop_zone",
	"building.black_market",
	"building.internet_center",
	"fake.black_market"
}

BaseDefense =
{
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

Infantry =
{
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

Tank =
{
	"vehicle.crusader_tank",
	"vehicle.paladin_tank",
	"vehicle.scorpion_tank",
	"vehicle.marauder_tank",
	"vehicle.battlemaster_tank",
	"vehicle.nuclear_battlemaster_tank",
	"vehicle.overlord_tank",
	"vehicle.emparor_overlord"
}

Artillery =
{
	"vehicle.tomahawk_launcher",
	"vehicle.rocket_buggy",
	"vehicle.scud_launcher",
	"vehicle.inferno_cannon",
	"vehicle.nuke_cannon"
}

Dozer =
{
	"vehicle.usa_mcc",
	"vehicle.gla_mcc",
	"vehicle.prc_mcc",
	"vehicle.tech_mcc"
}

Plane =
{
	"aircraft.raptor",
	"aircraft.king_raptor",
	"aircraft.stealth_fighter",
	"aircraft.stealth_fighter.air",
	"aircraft.aurora",
	"aircraft.aurora_alpha",
	"aircraft.mig"
}
IsPlane = function(actor)
	return
		actor.Type == "aircraft.raptor" or
		actor.Type == "aircraft.king_raptor" or
		actor.Type == "aircraft.stealth_fighter" or
		actor.Type == "aircraft.stealth_fighter.air" or
		actor.Type == "aircraft.aurora" or
		actor.Type == "aircraft.aurora_alpha" or
		actor.Type == "aircraft.mig"
end

CommandCenter =
{
	"building.usa_command_center",
	"building.gla_command_center",
	"building.prc_command_center",
	"building.prc_command_center.radar",
	"fake.command_center"
}

Barracks =
{
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

WarFactory =
{
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

AdvancedBuilding =
{
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

Airfield =
{
	"building.usa_airfield",
	"building.prc_airfield"
}

ParticleCannon =
{
	"building.particle_cannon",
	"building.particle_cannon.super"
}
IsParticleCannon = function(actor)
	return
		actor.Type == "building.particle_cannon" or
		actor.Type == "building.particle_cannon.super"
end

ScudStorm =
{
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

MissileSilo =
{
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

Hacker =
{
	"infantry.hacker",
	"infantry.super_hacker",
}

Burton =
{
	"infantry.colonel_burton",
}

Jarmen =
{
	"infantry.jarmen_kell",
	"infantry.jarmen_kell.demo",
}

Lotus =
{
	"infantry.black_lotus",
	"infantry.super_lotus",
}

TechBuilding =
{
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

CivilianBuilding =
{
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
