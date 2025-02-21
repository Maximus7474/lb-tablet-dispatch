local lastfight = 0
local timeout = 30 * 1000 --[[ 30 seconds ]]

local GetGameTimer = GetGameTimer

local Config = {
<<<<<<< Updated upstream
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
<<<<<<< HEAD
    delay = 0, -- in seconds
    percentage = 100, -- percent chance that the police are informed
    copsCanTrigger = true,
    policeJobs = {"police"},

    -- Excluded melee weapons
    excludedWeapons = {
        [`WEAPON_KNIFE`] = true,
        [`WEAPON_BAT`] = true,
        [`WEAPON_CROWBAR`] = true,
        [`WEAPON_GOLFCLUB`] = true,
        [`WEAPON_HAMMER`] = true,
        [`WEAPON_NIGHTSTICK`] = true,
        [`WEAPON_UNARMED`] = false
    }
}

AddEventHandler('CEventMeleeAction', function()
    print("^2[Melee Action] ^7Melee action detected.")
    
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then return end

    if not Config.copsCanTrigger and HasJob(Config.policeJobs) then return end

    local gametime = GetGameTimer()
    if lastfight > gametime then return end

    if not ShouldNotify(Config.percentage) then return end

    local target = GetMeleeTargetForPed(playerPed)

    if not DoesEntityExist(target) or target == playerPed then
        print("^3[Ignored Target] ^7No valid target.")
        return
    end

    -- Check if the target is a player or an NPC
    if not (IsPedAPlayer(target) or IsPedHuman(target)) then
        print("^3[Ignored Target] ^7Target is not a player or human NPC.")
        return
    end

    if not IsPedRagdoll(target) then
        print("^3[No Hit] ^7Target was not ragdolled.")
        return
    end

    -- Check the weapon used
    local weapon = GetSelectedPedWeapon(playerPed)
    if Config.excludedWeapons[weapon] then
        print("^1[Excluded Weapon] ^7Weapon did not trigger dispatch.")
        return
    end

    lastfight = gametime + timeout

    local coords = GetEntityCoords(playerPed)
    local street, zone = GetStreetAndAreaFromCoords(coords)

    Wait(Config.delay * 1000)

    local gender = IsPedMale(playerPed) and "Man" or "Woman"

    local data = {
        priority = 'medium',
        code = '10-10',
        title = 'Fight',
        description = ('A fight involving a %s has been reported at %s'):format(
            gender,
            street
        ),
        location = {
            label = ('%s, %s'):format(street, zone),
            coords = { x = coords.x, y = coords.y }
        },
        time = 300,
        job = 'police',
        fields = {
            { icon = 'person', label = 'Gender', value = gender }
        }
    }

    print("^2[Fight Detected] ^7 Dispatch Triggered.")

    TriggerServerEvent('tablet:dispatch:triggerDispatch', data)

    ClearEntityLastDamageEntity(playerPed)
end)

=======
<<<<<<< Updated upstream
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
    delay = 5,
    percentage = 35,
    copsCanTrigger = true,
    policeJobs = {"police"},
}

Citizen.CreateThread(function()
    while true do
        Wait(1000)

        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then goto continue end

        if not Config.copsCanTrigger and HasJob(Config.policeJobs) then goto continue end

        local gametime = GetGameTimer()
        if lastfight > gametime then goto continue end

        if not ShouldNotify(Config.percentage) then goto continue end

        -- Check if player is in melee combat
        if IsPedInMeleeCombat(playerPed) then
            local target = GetMeleeTargetForPed(playerPed)

            if DoesEntityExist(target) and target ~= playerPed then
                if IsPedAPlayer(target) or IsPedHuman(target) then
                    lastfight = gametime + timeout

                    local coords = GetEntityCoords(playerPed)
                    local street, zone = GetStreetAndAreaFromCoords(coords)

                    Wait(Config.delay * 1000)

                    local gender = IsPedMale(playerPed) and "Man" or "Woman"

                    local data = {
                        priority = 'medium',
                        code = '10-10',
                        title = 'Fight',
                        description = ('A fight involving a %s has been reported at %s'):format(
                            gender,
                            street
                        ),
                        location = {
                            label = ('%s, %s'):format(street, zone),
                            coords = { x = coords.x, y = coords.y }
                        },
                        time = 300,
                        job = 'police',
                        fields = {
                            { icon = 'person', label = 'Gender', value = gender }
                        }
                    }

                    --print("^2[Fight Detected] ^7 Dispatch Triggered.")

                    TriggerServerEvent('tablet:dispatch:triggerDispatch', data)

                    ClearEntityLastDamageEntity(playerPed)
                end
            end
        end

        ::continue::
    end
end)
<<<<<<< Updated upstream
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
>>>>>>> 15afb9c311c7ece9d18f0e06c0a03d812fb8e86a
>>>>>>> Stashed changes
=======
>>>>>>> 15afb9c311c7ece9d18f0e06c0a03d812fb8e86a
>>>>>>> Stashed changes
=======
>>>>>>> 15afb9c311c7ece9d18f0e06c0a03d812fb8e86a
>>>>>>> Stashed changes
