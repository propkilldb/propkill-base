GM.Name = "Propkill"
GM.Author = "Iced Coffee & Almighty Laxz"
GM.Email = "N/A"
GM.Website = "N/A"
GM.TeamBased = false

DeriveGamemode("sandbox")

function GM:CreateTeams()
	TEAM_DEATHMATCH = 1
	TEAM_UNASSIGNED = 0
	team.SetUp(TEAM_DEATHMATCH, "Deathmatch", Color(0, 255, 20, 255))
	team.SetUp(TEAM_UNASSIGNED, "Spectator", Color(70, 70, 70, 255))
end

--remove bhop clamp
local base = baseclass.Get('player_sandbox')
base['FinishMove'] = function() end
baseclass.Set('player_sandbox', base)

-- fix robottard spectator collisions
hook.Add("ShouldCollide", "ss_noteamcollide", function(ent,ent2)
	if ent:IsPlayer() and IsValid(ent) and ent2:IsPlayer() and IsValid(ent2) then
		if ent2:Team() == TEAM_UNASSIGNED then
			return false
		elseif ent:Team() == ent2:Team() then
			return false
		else
			return true
		end
	end
end)