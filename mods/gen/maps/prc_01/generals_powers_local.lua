--[[
   Copyright (c) The OpenRA Developers and Contributors
   This file is part of OpenRA, which is free software. It is made
   available to you under the terms of the GNU General Public License
   as published by the Free Software Foundation, either version 3 of
   the License, or (at your option) any later version. For more
   information, see COPYING.
]]

GPModifier = Map.LobbyOption("gpmodifier")

if GPModifier == "one" then
	PointsPerRank = { 1, 1, 1, 1, 1 }
elseif GPModifier == "normal" then
	PointsPerRank = { 1, 1, 1, 1, 3 }
elseif GPModifier == "two" then
	PointsPerRank = { 2, 2, 2, 2, 2 }
elseif GPModifier == "double" then
	PointsPerRank = { 2, 2, 2, 2, 6 }
elseif GPModifier == "three" then
	PointsPerRank = { 3, 3, 3, 3, 3 }
elseif GPModifier == "triple" then
	PointsPerRank = { 3, 3, 3, 3, 9 }
else
	PointsPerRank = { 5, 0, 15, 0, 5 }
end

PointActorExists = 
{
	PRC = false,
	GLA = false
}

Points = 
{
	PRC = PointsPerRank[1],
	GLA = PointsPerRank[1]
}

HasPointsActors = 
{
	PRC = nil,
	GLA = nil
}

Levels =
{
	PRC = 0,
	GLA = 0
}

Ranks = { "1 Star General", "2 Stars General", "3 Stars General", "4 Stars General", "5 Stars General" }
RankXPs = { 0, 800, 1500, 2500, 5000 }

ReducePoints = function(player)
	Trigger.OnProduction(player.GetActorsByType("player")[1], function()
		if Points[player.InternalName] > 0 then
			Points[player.InternalName] = Points[player.InternalName] - 1
		end
	end)
end

Tick = function()
	local localPlayerIsNull = true
	for _,player in pairs(players) do
		if player.IsLocalPlayer then
			localPlayerIsNull = false
			if Levels[player.InternalName] < 1 then
				UserInterface.SetMissionText("Current Rank: " .. Ranks[Levels[player.InternalName] + 1] .. "\nGeneral's Points: " .. Points[player.InternalName] .. "\nProgress to Next Rank: " .. player.Experience - RankXPs[Levels[player.InternalName] + 1] .. "/" .. RankXPs[Levels[player.InternalName] + 2] - RankXPs[Levels[player.InternalName] + 1] .. "", player.Color)
			else 
				UserInterface.SetMissionText("Current Rank: " .. Ranks[Levels[player.InternalName] + 1] .. "\nGeneral's Points: " .. Points[player.InternalName] .. "", player.Color)
			end
		end

		if localPlayerIsNull then
			UserInterface.SetMissionText("")
		end

		if Points[player.InternalName] > 0 and not PointActorExists[player.InternalName] then
			HasPointsActors[player.InternalName] = Actor.Create("hack.has_points", true, { Owner = player })

			PointActorExists[player.InternalName] = true
		end

		if not (Points[player.InternalName] > 0) and PointActorExists[player.InternalName] and HasPointsActors[player.InternalName] ~= nil then
			HasPointsActors[player.InternalName].Destroy()

			PointActorExists[player.InternalName] = false
		end

		if player.Experience >= RankXPs[2] and not (Levels[player.InternalName] > 0) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1
			Points[player.InternalName] = Points[player.InternalName] + PointsPerRank[2]

			Media.PlaySpeechNotification(player, "RankUp")
		end
	end
end
