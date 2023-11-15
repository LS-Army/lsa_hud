RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
    Wait(1000)
    loadScript()
end)


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Wait(1000)
    loadScript()
end)

function loadScript()
    if Config.CircleMap then
        CreateThread(function()
            DisplayRadar(false)
            RequestStreamedTextureDict('circlemap', false)
            repeat Wait(100) until HasStreamedTextureDictLoaded('circlemap')
            AddReplaceTexture('platform:/textures/graphics', 'radarmasksm', 'circlemap', 'radarmasksm')

            SetMinimapClipType(1)
            SetMinimapComponentPosition('minimap', 'L', 'B', -0.017, 0.021, 0.207, 0.32)
            SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.06, 0.05, 0.132, 0.260)
            SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.005, -0.01, 0.166, 0.257)

            Wait(500)
            SetBigmapActive(true, false)
            Wait(500)
            SetBigmapActive(false, false)
            SetBlipAlpha(GetNorthRadarBlip(), 0)

            local minimap = RequestScaleformMovie('minimap')
            repeat Wait(100) until HasScaleformMovieLoaded(minimap)

            DisplayRadar(true)
            while true do
                BeginScaleformMovieMethod(minimap, 'SETUP_HEALTH_ARMOUR')
                ScaleformMovieMethodAddParamInt(3)
                EndScaleformMovieMethod()
                SetRadarZoom(1100)
                local health = GetEntityHealth(cache.ped) / 2
                local armour = GetPedArmour(cache.ped)

                SendNUIMessage({
                    type = "show",
                    health = health,
                    armor = armour
                })
                Wait(200)
            end
        end)
    else
        CreateThread(function()
            Wait(500)
            SetBigmapActive(true, false)
            Wait(500)
            SetBigmapActive(false, false)

            while true do
                BeginScaleformMovieMethod(minimap, 'SETUP_HEALTH_ARMOUR')
                ScaleformMovieMethodAddParamInt(3)
                EndScaleformMovieMethod()

                local health = GetEntityHealth(cache.ped) / 2
                local armour = GetPedArmour(cache.ped)

                SendNUIMessage({
                    type = "show",
                    health = health,
                    armor = armour
                })
                Wait(200)
            end
        end)
    end
end
