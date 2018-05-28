--[[
   Copyright 2007-2018 The OpenRA Developers (see AUTHORS)
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

Cars = { car1, car2 }
CarBunkers = { PRCBunker1, PRCBunker2 }

Battlemasters = { Battlemaster1, Battlemaster2, Battlemaster3, Battlemaster4, Battlemaster5 }
Survivors1 = { SurvivorBM1, SurvivorBM2, SurvivorDT1, SurvivorDT2 }
Survivors2 = { SurvivorOT1, SurvivorOT2 }

MiG = { "aircraft.mig" }
MiGTargets = { MiGCutsceneST1, MiGCutsceneST2, MiGCutsceneTech1, MiGCutsceneTech2, MiGCutsceneTech3, MiGCutsceneTech4, MiGCutsceneInf1, MiGCutsceneInf2, MiGCutsceneInf3, MiGCutsceneInf4, MiGCutsceneInf5 }
MiGTrigger = { CPos.New(53, 47), CPos.New(53, 48), CPos.New(53, 49) }

StartingCash =
{
	easy = 20000,
	normal = 15000,
	hard = 10000,
}

CarAttackTimes =
{
	easy = DateTime.Seconds(10),
	normal = DateTime.Seconds(7),
	hard = DateTime.Seconds(5)
}

BunkerCarAttack = function(number)
	local car = Cars[number]

	car.Owner = gla

	PlaceMeBomb(car)
	car.DetonateAttack(CarBunkers[number])
end

PlaceMeBomb = function(unit)
	unit.GrantCondition("car_bomb")
end

SendMiG = function(entry, target)
	local mig = Reinforcements.Reinforce(prc, MiG, { entry.Location, entry.Location })
	mig[1].Attack(target)
end

SetupDifficulties = function()
	prc.Cash = StartingCash[Difficulty]

	if Difficulty == "easy" or Difficulty == "normal" then
		GLAStinger1.Destroy()
		GLAStinger2.Destroy()
		MediumTech1.Destroy()
		MediumTech2.Destroy()
		AttackInf1.Destroy()
		AttackInf2.Destroy()
		AttackInf6.Destroy()
		SplodeGuy1.Destroy()
		SplodeGuy2.Destroy()
	end
	if Difficulty == "easy" then
		EasyTech1.Destroy()
		EasyTech2.Destroy()
		EasyTech3.Destroy()
		AttackInf3.Destroy()
		AttackInf4.Destroy()
	end
end

InitObjectives = function()
	Trigger.OnObjectiveAdded(prc, function(p, id)
		Media.DisplayMessage(p.GetObjectiveDescription(id), "New " .. string.lower(p.GetObjectiveType(id)) .. " objective")
	end)

	DestroyBunker = prc.AddPrimaryObjective("Destroy the GLA Nuclear Bunker.")
	GuardBunker = gla.AddPrimaryObjective("Guard the Nuclear Bunker.")

	Trigger.OnObjectiveCompleted(prc, function(p, id)
		Media.DisplayMessage(p.GetObjectiveDescription(id), "Objective completed")
	end)
	Trigger.OnObjectiveFailed(prc, function(p, id)
		Media.DisplayMessage(p.GetObjectiveDescription(id), "Objective failed")
	end)

	Trigger.OnPlayerLost(prc, function()
		Trigger.AfterDelay(DateTime.Seconds(1), function()
			Media.PlaySpeechNotification(prc, "Lose")
		end)
	end)
	Trigger.OnPlayerWon(prc, function()
		Trigger.AfterDelay(DateTime.Seconds(1), function()
			Media.PlaySpeechNotification(prc, "Win")
		end)
	end)
end

WorldLoaded = function()
	prc = Player.GetPlayer("PRC")
	gla = Player.GetPlayer("GLA")

	players = { prc, gla }
	for _,player in pairs(players) do
		ReducePoints(player)
	end

	Difficulty = Map.LobbyOption("difficulty")
	SetupDifficulties()

	Camera.Position = PRCCommand.CenterPosition
	InitObjectives()
	
	Trigger.OnEnteredFootprint(MiGTrigger, function(a, id)
		Trigger.RemoveFootprintTrigger(id)

		SendMiG(MiGEntry1, MiGCutsceneST1)
		SendMiG(MiGEntry2, MiGCutsceneTech2)
		SendMiG(MiGEntry3, MiGCutsceneTech4)
		SendMiG(MiGEntry4, MiGCutsceneInf3)

		Utils.Do(MiGTargets, function(a)
			a.AttackMove(MiGTargetsMoveWaypoint.Location)
		end)

		Camera.Position = MiGRevealWaypoint.CenterPosition
		local camera = Actor.Create("camera.spyplane", true, { Owner = prc, Location = MiGRevealWaypoint.Location })
		Trigger.AfterDelay(DateTime.Seconds(30), function()
			camera.Destroy()
		end)
	end)

	Trigger.AfterDelay(CarAttackTimes[Difficulty], function()
		BunkerCarAttack(1)
		BunkerCarAttack(2)
	end)

	Trigger.OnDiscovered(BattlemasterTrigger, function(discovered, discoverer)
		if discoverer == prc then
			Utils.Do(Battlmeasters, function(a)
				a.Owner = prc
				a.Move(BattlemasterWaypoint)
			end)
		end
	end)

	Utils.Do(Survivors1, function(survivor)
		Trigger.OnDiscovered(survivor, function(discovered, discoverer)
			if discoverer == prc then
				Utils.Do(Survivors1, function(a)
					a.Owner = prc
				end)
			end
		end)
	end)

	Utils.Do(Survivors2, function(survivor)
		Trigger.OnDiscovered(survivor, function(discovered, discoverer)
			if discoverer == prc then
				Utils.Do(Survivors2, function(a)
					a.Owner = prc
				end)
			end
		end)
	end)

	Trigger.OnKilled(GLANukeBunker, function()
		prc.MarkCompletedObjective(DestroyBunker)
	end)
end
