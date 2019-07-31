function ChangeTeam(ply, cmd, args)
	if GetGlobalBool("PK_Dueling") then
		ply:ChatPrint("no")
		return
	end
	local teamindex = tonumber(args[1])
	if teamindex < 1000 and team.Valid(teamindex) then
		GAMEMODE:PlayerJoinTeam(ply, teamindex)
	end
end
concommand.Add("pk_team", ChangeTeam)

concommand.Add("rserver", function(ply)
   if ply == NULL or ply:IsSuperAdmin() then
      RunConsoleCommand("changelevel", game.GetMap(), engine.ActiveGamemode())
   end
end)

function ConfigSet(ply, cmd, args)
	if #args == 0 then return false end

	if PK_Config[args[1]] == nil then
		ply:ChatPrint("Config option '".. args[1] .."' does not exist")
		return false
	else
		if args[2] and !args[3] then
			if args[2] == "true" then
				PK_Config[args[1]] = true
				ply:ChatPrint("Set " .. args[1] .. " to true")
			elseif args[2] == "false" then
				PK_Config[args[1]] = false
				ply:ChatPrint("Set " .. args[1] .. " to false")
			end
		elseif args[2] and args[3] and istable(PK_Config[args[1]]) then
			local tbl = {}
			for k,v in pairs(args) do
				if k == 1 then continue end
				table.insert(tbl, tostring(args[k]))
			end
			PK_Config[args[1]] = tbl
		else
			ply:ChatPrint("Invalid or no value specified!")
			return false
		end
	end
end
concommand.Add("pk_setconfig", ConfigSet)

function ConfigSet(ply, cmd, args)
	PrintTable(PK_Config)
	for k,v in pairs(PK_Config) do
		if !istable(v) then
			ply:ChatPrint(tostring(k) .. " = " .. tostring(v) .. " - " .. type(v))
		else
			ply:ChatPrint(tostring(k) .. " = " .. "{" .. table.concat(v, ", ") .. "}" .. " - " .. type(v))
		end
	end
end
concommand.Add("pk_getconfig", ConfigSet)

function StartGame()
	// Should be overridden
end

function WarmUp()
	SetGlobalBool("Warmup", true)
	timer.Simple(60, function()
		SetGlobalBool("Warmup", false)
		StartGame()
	end)
end

function PK_PhysSettings()
	if ply:IsSuperAdmin() then
		if args[1] then
			physenv.SetPerformanceSettings(
				{
					LookAheadTimeObjectsVsObject = 2,
					LookAheadTimeObjectsVsWorld = 21,
					MaxAngularVelocity = 3636,
					MaxCollisionChecksPerTimestep = 5000,
					MaxCollisionsPerObjectPerTimestep = 48,
					MaxFrictionMass = 1,
					MaxVelocity = 2200,
					MinFrictionMass = 99999,
				}
			)
			game.ConsoleCommand("physgun_DampingFactor 1\n")
			game.ConsoleCommand("physgun_timeToArrive 0.01\n")
			game.ConsoleCommand("sv_sticktoground 0\n")
			game.ConsoleCommand("sv_airaccelerate 2000\n")
			ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Australian physics settings enabled"})
		else
			// ??
			ChatMsg({Color(0,200,0), "[PK:R]: ", Color(200,200,200), "Australian physics settings disabled"})
		end
	end
end
concommand.Add("pk_physsettings", PK_PhysSettings)