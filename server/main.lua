lib.versionCheck('LS-Army/lsa_hud')

CreateThread(function()
    if Config.SaveArmour then
        lib.cron.new("*/1 * * * *", cronTask, { debug = true })
    else
        print('Armour save not enabled in config')
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(id, player, isNew)
    local data = MySQL.Sync.fetchScalar(
        "SELECT status FROM users WHERE identifier = ?",
        { player.getIdentifier() }
    )
    local jsonData = data and json.decode(data)

    SetPedArmour(GetPlayerPed(id), jsonData.armour)
end)


function cronTask(task, date)
    print("Armor successfully saved")
    local players = GetPlayers()
    if #players > 0 then
        for k, v in ipairs(players) do
            local player = ESX.GetPlayerFromId(v)
            if player then
                local currentArmor = GetPedArmour(GetPlayerPed(v))

                local existingData = MySQL.Sync.fetchScalar(
                    "SELECT status FROM users WHERE identifier = ?",
                    { player.getIdentifier() }
                )

                local jsonData = existingData and json.decode(existingData) or {}
                jsonData.armour = currentArmor

                MySQL.Sync.execute(
                    "UPDATE users SET status = ? WHERE identifier = ?",
                    { json.encode(jsonData), player.getIdentifier() }
                )
            end
        end
    end
end
