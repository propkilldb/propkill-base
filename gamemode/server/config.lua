pk_config_file = file.Read("pkr_sv_config.txt")

function PK_SaveConfig()
	file.Write("pkr_settings.txt", util.TableToJSON(PK_Config))
end

pk_config_file = file.Read("pkr_sv_config.txt")

PK_Config = nil

if pk_config_file then
	PK_Config = util.JSONToTable(pk_config_file)
else
	PK_Config = {
		maxprops = 7,
		limitfrozenprops = true,
		maxfrozenprops = 3,
		toolgunenabled = false
	}
	PK_SaveConfig()
end


function PK_SetConfig(setting, value)
	PK_Config[setting] = value
	PK_SaveConfig()
end

function PK_GetConfig(setting)
	return PK_Config[setting]
end

RunConsoleCommand("sbox_noclip", "0")
RunConsoleCommand("sbox_maxprops", PK_Config.maxprops)