Citizen.CreateThread(function()
    Wait(500)
    SetHudComponentPosition(6, 999999.0, 999999.0)
    SetHudComponentPosition(7, 999999.0, 999999.0)
    local minimap = RequestScaleformMovie("minimap")
    SetBigmapActive(true, false)
    Wait(0)
    SetBigmapActive(false, false)

    while true do
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()

        local health = GetEntityHealth(cache.ped) / 2
        local armor = GetPedArmour(cache.ped)

        SendNUIMessage({
            type = "show",
            health = health,
            armor = armor
        })

        Wait(1000)
    end
end)
