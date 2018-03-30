--[[
   Copyright 2007-2018 The OpenRA Developers (see AUTHORS)
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

PointConditionGiven = 
{
	Multi0 = false,
	Multi1 = false,
	Multi2 = false,
	Multi3 = false,
	Multi4 = false,
	Multi5 = false,
	Multi6 = false,
	Multi7 = false,
	Multi8 = false,
	Multi9 = false,
	Multi10 = false,
	Multi11 = false
}

Points = 
{
	Multi0 = PointsPerRank[1],
	Multi1 = PointsPerRank[1],
	Multi2 = PointsPerRank[1],
	Multi3 = PointsPerRank[1],
	Multi4 = PointsPerRank[1],
	Multi5 = PointsPerRank[1],
	Multi6 = PointsPerRank[1],
	Multi7 = PointsPerRank[1],
	Multi8 = PointsPerRank[1],
	Multi9 = PointsPerRank[1],
	Multi10 = PointsPerRank[1],
	Multi11 = PointsPerRank[1]
}

PointConditionToken = 
{
	Multi0 = 1,
	Multi1 = 1,
	Multi2 = 1,
	Multi3 = 1,
	Multi4 = 1,
	Multi5 = 1,
	Multi6 = 1,
	Multi7 = 1,
	Multi8 = 1,
	Multi9 = 1,
	Multi10 = 1,
	Multi11 = 1
}

Levels =
{
	Multi0 = 0,
	Multi1 = 0,
	Multi2 = 0,
	Multi3 = 0,
	Multi4 = 0,
	Multi5 = 0,
	Multi6 = 0,
	Multi7 = 0,
	Multi8 = 0,
	Multi9 = 0,
	Multi10 = 0,
	Multi11 = 0
}

Ranks = { "1 Star General", "2 Star General", "3 Star General", "4 Star General", "5 Star General" }
RankXPs = { 0, 1000, 2000, 3000, 4000 }

ReducePoints = function(player)
	Trigger.OnProduction(player.GetActorsByType("player")[1], function()
		if Points[player.InternalName] > 0 then
			Points[player.InternalName] = Points[player.InternalName] - 1
		end
	end)
end

Tick = function()
	for _,player in pairs(players) do
		if player.IsLocalPlayer then
			if Levels[player.InternalName] < 4 then
				UserInterface.SetMissionText("Current Rank: " .. Ranks[Levels[player.InternalName] + 1] .. "\nGenerals Points: " .. Points[player.InternalName] .. "\nProgress to Next Rank: " .. player.Experience - RankXPs[Levels[player.InternalName] + 1] .. "/" .. RankXPs[Levels[player.InternalName] + 2] - RankXPs[Levels[player.InternalName] + 1] .. "", player.Color)
			else 
				UserInterface.SetMissionText("Current Rank: " .. Ranks[Levels[player.InternalName] + 1] .. "\nGenerals Points: " .. Points[player.InternalName] .. "", player.Color)
			end
		end

		if Points[player.InternalName] > 0 and not PointConditionGiven[player.InternalName] then
			player.GetActorsByType("player")[1].GrantCondition("points")

			PointConditionGiven[player.InternalName] = true
		end

		if not (Points[player.InternalName] > 0) and PointConditionGiven[player.InternalName] then
			player.GetActorsByType("player")[1].RevokeCondition(PointConditionToken[player.InternalName])
			PointConditionToken[player.InternalName] = PointConditionToken[player.InternalName] + 1

			PointConditionGiven[player.InternalName] = false
		end

		if player.Experience >= 1000 and not (Levels[player.InternalName] > 0) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1
			Points[player.InternalName] = Points[player.InternalName] + PointsPerRank[2]
		end

		if player.Experience >= 2000 and not (Levels[player.InternalName] > 1) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1
			Points[player.InternalName] = Points[player.InternalName] + PointsPerRank[3]

			Actor.Create("hack.rank_3", true, { Owner = player })
		end

		if player.Experience >= 3000 and not (Levels[player.InternalName] > 2) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1
			Points[player.InternalName] = Points[player.InternalName] + PointsPerRank[4]
		end

		if player.Experience >= 4000 and not (Levels[player.InternalName] > 3) then
			Levels[player.InternalName] = Levels[player.InternalName] + 1
			Points[player.InternalName] = Points[player.InternalName] + PointsPerRank[5]

			Actor.Create("hack.rank_5", true, { Owner = player })
		end
	end
end

WorldLoaded = function()
	neutral = Player.GetPlayer("Neutral")
	mp0 = Player.GetPlayer("Multi0")
	mp1 = Player.GetPlayer("Multi1")
	mp2 = Player.GetPlayer("Multi2")
	mp3 = Player.GetPlayer("Multi3")
	mp4 = Player.GetPlayer("Multi4")
	mp5 = Player.GetPlayer("Multi5")
	mp6 = Player.GetPlayer("Multi6")
	mp7 = Player.GetPlayer("Multi7")
	mp8 = Player.GetPlayer("Multi8")
	mp9 = Player.GetPlayer("Multi9")
	mp10 = Player.GetPlayer("Multi10")
	mp11 = Player.GetPlayer("Multi11")

	players = {mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7, mp8, mp9, mp10, mp11 }

	for _,player in pairs(players) do
		ReducePoints(player)
	end
end
