--[[
   Copyright 2007-2018 The OpenRA Developers (see AUTHORS)
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

RandomTaunts = { "19", "15", "16", "17", "18", "20", "22", "23", "24", "25", "26", "27", "29", "30" }

ResearchUpgrade = function(building, upgrade)
	local buildings = enemy.GetActorsByType(building)
	if #buildings > 0 then
		buildings[1].Build( { upgrade } )
	else
		Trigger.AfterDelay(DateTime.Minutes(1), function()
			ResearchUpgrade(building, upgrade)
		end)
	end
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

lowPowerTauntTimer = 0
randomTauntTimer = Utils.RandomInteger(DateTime.Seconds(45), DateTime.Seconds(120))
randomTauntToPlay = 1
Tick = function()
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

	ResearchUpgrade("building.prc_war_factory", "upgrade.chain_gun")
	ResearchUpgrade("building.prc_airfield", "upgrade.mig_armor")
	ResearchUpgrade("building.propaganda_center", "upgrade.nationalism")
	ResearchUpgrade("building.missile_silo", "upgrade.nuclear_tanks")

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
