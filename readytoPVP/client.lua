local safezone = Config.SpawnLocation
local radius = Config.SafeZoneRadius
local isInSafeZone = false

-- Nekonečný sprint
CreateThread(function()
    while true do
        Wait(0)
        RestorePlayerStamina(PlayerId(), 1.0)
    end
end)

-- Respawn hráče na spawn po smrti
AddEventHandler('esx:onPlayerSpawn', function()
    SetEntityCoords(PlayerPedId(), Config.SpawnLocation.x, Config.SpawnLocation.y, Config.SpawnLocation.z)
end)

-- Safezóna detekce
CreateThread(function()
    while true do
        Wait(500)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local dist = #(coords - safezone)

        if dist < radius and not isInSafeZone then
            isInSafeZone = true
            SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
            ESX.ShowNotification("Vstoupil jsi do SAFEZÓNY")
        elseif dist >= radius and isInSafeZone then
            isInSafeZone = false
            ESX.ShowNotification("Opustil jsi SAFEZÓNU")
        end
    end
end)

-- Blokace zbraní v safezóně
CreateThread(function()
    while true do
        Wait(0)
        if isInSafeZone then
            DisablePlayerFiring(PlayerPedId(), true)
        end
    end
end)
