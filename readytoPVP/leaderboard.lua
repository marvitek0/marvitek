local KDStats = {}

RegisterNetEvent('pvp:addKill')
AddEventHandler('pvp:addKill', function(playerID)
    if not KDStats[playerID] then
        KDStats[playerID] = {kills = 0, deaths = 0}
    end
    KDStats[playerID].kills = KDStats[playerID].kills + 1
end)

RegisterNetEvent('pvp:addDeath')
AddEventHandler('pvp:addDeath', function(playerID)
    if not KDStats[playerID] then
        KDStats[playerID] = {kills = 0, deaths = 0}
    end
    KDStats[playerID].deaths = KDStats[playerID].deaths + 1
end)

RegisterCommand('leaderboard', function(source)
    local sortedKD = {}
    for id, stats in pairs(KDStats) do
        table.insert(sortedKD, {id = id, kills = stats.kills, deaths = stats.deaths})
    end

    -- Seřadí podle počtu kills (od nejlepšího)
    table.sort(sortedKD, function(a, b) return a.kills > b.kills end)
    
    -- Vypíše leaderboard
    for i, player in ipairs(sortedKD) do
        print(i .. '. ' .. player.id .. ' | Kills: ' .. player.kills .. ' | Deaths: ' .. player.deaths)
    end
end)
