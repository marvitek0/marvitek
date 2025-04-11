ESX.RegisterServerCallback('pvp:npcWeaponShop', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    -- Zbraně dostupné pro prodej
    local weapons = {
        {name = "weapon_pistol", label = "Pistole", price = 500},
        {name = "weapon_shotgun", label = "Brokovnice", price = 1000},
        {name = "weapon_assaultrifle", label = "Útočná puška", price = 3000}
    }

    -- Funkce pro koupi zbraně
    RegisterNetEvent('pvp:buyWeapon')
    AddEventHandler('pvp:buyWeapon', function(weaponName)
        if xPlayer.getMoney() >= weapon.price then
            xPlayer.removeMoney(weapon.price)
            xPlayer.addWeapon(weapon.name)
            TriggerClientEvent('esx:showNotification', source, 'Zakoupil jsi ' .. weapon.label)
        else
            TriggerClientEvent('esx:showNotification', source, 'Nemáš dostatek peněz!')
        end
    end)

    cb(weapons)
end)
