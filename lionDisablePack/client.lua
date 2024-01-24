--Disable Gagflight
Citizen.CreateThread(function()
    if Config.DisableGangFight then
        while true do
            Citizen.Wait(0)
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey('PLAYER'))
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_CULT"), GetHashKey('PLAYER'))
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_WEICHENG"), GetHashKey('PLAYER'))
            SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
        end
    end
end)




-- Disable NPCs
Citizen.CreateThread(function()
    if Config.NPCs == 'disable' then
        while true do
            Citizen.Wait(0)
            SetCreateRandomCops(false)
            SetCreateRandomCopsNotOnScenarios(false)
            SetCreateRandomCopsOnScenarios(false)
            SetGarbageTrucks(false)
            SetRandomBoats(false)
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetPedDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)

            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
            ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
            RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
        end
    elseif Config.NPCs == 'reduced' then
        while true do
            local DensityMultiplier = Config.Reduced
            Citizen.Wait(0)
            SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
            SetPedDensityMultiplierThisFrame(DensityMultiplier)
            SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
            SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
            SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
        end
    elseif Config.NPCs == 'normal' then
    end
end)




--Disable Weapondrop
Citizen.CreateThread(function()
    if Config.DisableWeaponDrop then
        while true do
            Citizen.Wait(1)
            RemoveAllPickupsOfType(Config.WeaponDrop1)
            RemoveAllPickupsOfType(Config.WeaponDrop2)
            RemoveAllPickupsOfType(Config.WeaponDrop3)
        end
    end
end)




--Disable WeaponFromPolVehicle
local vehWeapons = {
	0x1D073A89,
	0x83BF0278,
	0x5FC3C11,
}
local hasBeenInPoliceVehicle = false
local alreadyHaveWeapon = {}

Citizen.CreateThread(function()
    if Config.DisableWeaponFromPolVeh then
        while true do
            Citizen.Wait(0)
            if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
                if(not hasBeenInPoliceVehicle) then
                    hasBeenInPoliceVehicle = true
                end
            else
                if(hasBeenInPoliceVehicle) then
                    for i,k in pairs(vehWeapons) do
                        if(not alreadyHaveWeapon[i]) then
                            TriggerServerEvent("lionDisablePack:askDropWeapon",k)
                        end
                    end
                    hasBeenInPoliceVehicle = false
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    if Config.DisableWeaponFromPolVeh then
        while true do
            Citizen.Wait(0)
            if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
                for i=1,#vehWeapons do
                    if(HasPedGotWeapon(GetPlayerPed(-1), vehWeapons[i], false)==1) then
                        alreadyHaveWeapon[i] = true
                    else
                        alreadyHaveWeapon[i] = false
                    end
                end
            end
            Citizen.Wait(5000)
        end
    end
end)

RegisterNetEvent("lionDisablePack:weaDrop")
AddEventHandler("lionDisablePack:weaDrop", function(wea)
    if Config.DisableWeaponFromPolVeh then
	    RemoveWeaponFromPed(GetPlayerPed(-1), wea)
    end
end)




--Disable Air Control
Citizen.CreateThread(function()
    if Config.DisableVehAirControl then
        while true do
            Citizen.Wait(0)
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if DoesEntityExist(veh) and not IsEntityDead(veh) then
                local model = GetEntityModel(veh)
                if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(veh) then
                    DisableControlAction(0, 59)
                    DisableControlAction(0, 60)
                end
            end
        end
    end
end)




--Disable Weapon Punch
Citizen.CreateThread(function()
    if Config.DisableWeaponPunch then
        while true do
            Citizen.Wait(0)
            local ped = GetPlayerPed( -1 )
            local weapon = GetSelectedPedWeapon(ped)
            if IsPedArmed(ped, 6) then
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            end
        end
    end
end)




--Disable Dispatch
Citizen.CreateThread(function()
    if Config.DisableDispatch then
        while true do
            Wait(0)
            for i = 1, 12 do
                EnableDispatchService(i, false)
            end
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
            SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
        end
    end
end)




--Disable Bigmap
Citizen.CreateThread(function()
    if Config.DisableBigMap then
        while true do
            Citizen.Wait(0)
            SetRadarBigmapEnabled(false, false)
        end
    end
end)




--Disable Combat Roll
Citizen.CreateThread(function()
    if Config.DisableCombatRoll then
        while true do
            Citizen.Wait(0)
            if IsPedArmed(GetPlayerPed(-1), 4 | 2) and IsControlPressed(0, 25) then
                DisableControlAction(0, 22, true)
            end
        end
    end
end)




--Disable Spam Punching
Citizen.CreateThread(function()
    if Config.DisableSpamPunching then
        while true do
            Citizen.Wait(0)
            DisableControlAction(1, 140, true)
            if not IsPlayerTargettingAnything(PlayerId()) then
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            end
        end
    end
end)