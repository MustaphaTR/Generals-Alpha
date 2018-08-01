--[[
   Copyright 2007-2018 The OpenRA Developers (see AUTHORS)
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

Barracks	= { "building.usa_barrakcs", "building.gla_barracks", "building.prc_barracks"}
WarFactory	= { "building.usa_war_factory", "building.arms_dealer", "building.prc_war_factory"}
Airfield	= { "building.usa_airfield", "building.prc_airfield"}

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
		
		PRCBunker1.Destroy()
		PRCBunker2.Destroy()
		PRCBunker3.Destroy()
		PRCBunker4.Destroy()
		PRCBunker5.Destroy()
		PRCBunker6.Destroy()
		PRCBunker7.Destroy()
	end

	if Difficulty == "hard" then
		player.Cash = player.Cash - ((player.Cash * 3) / 13)
	end
end

Tick = function()
	if 301 > player.Cash and not lowCashTauntPlayed then
		lowCashTauntPlayed = true
		Media.PlayTauntNotification(enemy, "61")
	end
end

WorldLoaded = function()
	player = Player.GetPlayer("Multi0")
	enemy = Player.GetPlayer("General Kwai")

	players = { player }

	for _,player in pairs(players) do
		ReducePoints(player)
	end

	Difficulty = Map.LobbyOption("difficulty")
	
	DifficultySetup()
	GiveGeneralPowers()
end
