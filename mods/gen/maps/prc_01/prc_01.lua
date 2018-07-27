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
CarBunkerLocations = { PRCBunker1.Location, PRCBunker2.Location }
CarTrigger = { CPos.New(28, 32), CPos.New(29, 32), CPos.New(30, 33), CPos.New(31, 33), CPos.New(32, 33), CPos.New(33, 33), CPos.New(34, 32), CPos.New(35, 32) }
HardCars = { car3, car4 }
HardCarTarget = PRCSupply
Terrorists = { SplodeGuy1, SplodeGuy2 }
BaseAttackForce = { EasyTech1, EasyTech2, AttackInf1, AttackInf2, AttackInf3, AttackInf4 }
BaseAttackForceLocation = PRCCommand.Location + CVec.New(1, 2)

Battlemasters = { Battlemaster1, Battlemaster2, Battlemaster3, Battlemaster4, Battlemaster5 }
BattlemasterTriggers = { Actor703, Actor705 }

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

BunkerCarAttack = function(number)
	local car = Cars[number]

	if not car.IsDead then
		car.Owner = gla

		PlaceMeBomb(car)
		car.Move(CarBunkerLocations[number] + CVec.New(0, 2))
		car.DetonateAttack(CarBunkers[number])
	end
end

BaseAttack = function()
	Utils.Do(HardCars, function(car)
		if Difficulty == "hard" and not car.IsDead then
			car.Owner = gla
			PlaceMeBomb(car)
			car.DetonateAttack(HardCarTarget)
		end
	end)

	Utils.Do(BaseAttackForce, function(attacker)
		if not attacker.IsDead then
			attacker.AttackMove(BaseAttackForceLocation)
		end
	end)

	Utils.Do(Terrorists, function(terrorist)
		if not terrorist.IsDead then
			terrorist.DetonateAttack(PRCCommand)

			Trigger.OnDamaged(terrorist, function()
				if terrorist.Health <= 1500 then
					terrorist.Detonate()
				end
			end)
		end
	end)
end

PlaceMeBomb = function(unit)
	unit.GrantCondition("car_bomb")
end

SendMiG = function(entry, target)
	local mig = Reinforcements.Reinforce(prc, MiG, { entry.Location, entry.Location })
	Utils.Do(mig, function(a)
		a.Attack(target)
		a.Move(entry.Location)
		a.Destroy()
	end)
end

SetupDifficulties = function()
	prc.Cash = StartingCash[Difficulty]

	if Difficulty == "easy" or Difficulty == "normal" then
		GLAStinger1.Destroy()
		GLAStinger2.Destroy()
		MediumTech1.Destroy()
		MediumTech2.Destroy()
		MediumTech4.Destroy()
		MediumTech5.Destroy()
		MediumScorp1.Destroy()
		MediumScorp2.Destroy()
		MediumScorp3.Destroy()
		MediumScorp4.Destroy()
		MediumScorp5.Destroy()
		AttackInf1.Destroy()
		AttackInf2.Destroy()
		AttackInf6.Destroy()
		AttackInf9.Destroy()
		AttackInf10.Destroy()
		SplodeGuy1.Destroy()
		SplodeGuy2.Destroy()
	end
	if Difficulty == "easy" then
		EasyTech1.Destroy()
		EasyTech2.Destroy()
		EasyTech3.Destroy()
		EasyScorp1.Destroy()
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

	Media.PlaySpeechNotification(prc, "MIS_PRC1_A")

	Difficulty = Map.LobbyOption("difficulty")
	SetupDifficulties()

	Camera.Position = PRCCommand.CenterPosition
	InitObjectives()

	Trigger.OnEnteredFootprint(MiGTrigger, function(a, id)
		if a.Owner == prc then
			Trigger.RemoveFootprintTrigger(id)
			
			Media.PlaySpeechNotification(prc, "MIS_PRC1_C")

			local units = prc.GetGroundAttackers()
			Utils.Do(units, function(a)
				a.Stop()
			end)

			Trigger.AfterDelay(DateTime.Seconds(6), function()
				Media.PlaySpeechNotification(prc, "MIS_PRC1_G")
				Camera.Position = MiGRevealWaypoint.CenterPosition

				SendMiG(MiGEntry1, MiGCutsceneST1)
				SendMiG(MiGEntry2, MiGCutsceneTech2)
				SendMiG(MiGEntry3, MiGCutsceneTech4)
				SendMiG(MiGEntry4, MiGCutsceneInf3)

				Utils.Do(MiGTargets, function(a)
					a.AttackMove(MiGTargetsMoveWaypoint.Location)
				end)

				Trigger.OnAllKilled(MiGTargets, function()
					Media.PlaySpeechNotification(prc, "MIS_PRC1_H")
				end)

				local camera = Actor.Create("camera.spyplane", true, { Owner = prc, Location = MiGRevealWaypoint.Location })
				Trigger.AfterDelay(DateTime.Seconds(30), function()
					camera.Destroy()

					Media.PlaySpeechNotification(prc, "MIS_PRC1_D")
				end)
			end)
		end
	end)

	Trigger.OnEnteredFootprint(CarTrigger, function(a, id)
		if a.Owner == prc then
			Trigger.RemoveFootprintTrigger(id)

			Media.PlaySpeechNotification(prc, "MIS_PRC1_I")
			Trigger.AfterDelay(DateTime.Seconds(5), function()
				BunkerCarAttack(1)
				BunkerCarAttack(2)
			end)

			Trigger.AfterDelay(DateTime.Seconds(10), function()
				BaseAttack()
			end)
		end
	end)

	Trigger.OnAllKilled(BattlemasterTriggers, function()
		Utils.Do(Battlemasters, function(a)
			a.Owner = prc
			a.Move(BattlemasterWaypoint.Location)
		end)

		Media.PlaySpeechNotification(prc, "MIS_PRC1_B")
	end)

	Utils.Do(Survivors1, function(survivor)
		Trigger.OnDiscovered(survivor, function(discovered, discoverer)
			if discoverer == prc then
				Utils.Do(Survivors1, function(a)
					a.Owner = prc
				end)

				Media.PlaySpeechNotification(prc, "MIS_PRC1_E")
			end
		end)
	end)

	Utils.Do(Survivors2, function(survivor)
		Trigger.OnDiscovered(survivor, function(discovered, discoverer)
			if discoverer == prc then
				Utils.Do(Survivors2, function(a)
					a.Owner = prc
				end)

				Media.PlaySpeechNotification(prc, "MIS_PRC1_F")
			end
		end)
	end)

	Trigger.OnKilled(GLATunnel1, function()
		Media.PlaySpeechNotification(prc, "MIS_PRC1_J")
	end)

	Trigger.OnKilled(GLANukeBunker, function()
		prc.MarkCompletedObjective(DestroyBunker)
	end)
end
