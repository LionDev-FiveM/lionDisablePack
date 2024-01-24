--Disable WeaponFromPolVehicle
local Cops = {
	"steam:100000000000",
}

RegisterServerEvent("lionDisablePack:askDropWeapon")
AddEventHandler("lionDisablePack:askDropWeapon", function(wea)
	if Config.DisableWeaponFromPolVeh then
		local isCop = false

		for _,k in pairs(Cops) do
			if(k == getPlayerID(source)) then
				isCop = true
				break;
			end
		end

		if(not isCop) then
			print(1)
			TriggerClientEvent("lionDisablePack:weaDrop", source, wea)
		end
	end
end)

function getPlayerID(source)
	if Config.DisableWeaponFromPolVeh then
		local identifiers = GetPlayerIdentifiers(source)
		local player = getIdentifiant(identifiers)

		return player
	end
end

function getIdentifiant(id)
	if Config.DisableWeaponFromPolVeh then
		for _, v in ipairs(id) do
			return v
		end
	end
end





Citizen.CreateThread(function()
    local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
    if vRaw and Config.VersionCheck then
        local v = json.decode(vRaw)
        local url = 'https://raw.githubusercontent.com/LionDev-FiveM/lionDisablePack/main/version.json'
        PerformHttpRequest(url, function(code, res)
            if code == 200 then
                local rv = json.decode(res)
                if rv.version ~= v.version then
                    print(([[
 _      _               _____                 _                                  _   
| |    (_)             |  __ \               | |                                | |  
| |     _  ___  _ __   | |  | | _____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_ 
| |    | |/ _ \| '_ \  | |  | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
| |____| | (_) | | | | | |__| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_ 
|______|_|\___/|_| |_| |_____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|
                                                    | |                             
                                                    |_|                             
Script: lionDisablePack
UPDATE: %s AVAILABLE
CHANGELOG: %s
Download: https://github.com/LionDev-FiveM/lionDisablePack
If you need help, join our Discord: https://dsc.gg/lion-dev
]]):format(rv.version, rv.changelog))
                end
            else
                print('Error in versioncheck')
            end
        end, 'GET')
    end
end)