local lastfight = 0
local timeout = 30 * 1000 --[[ 30 seconds ]]

local GetGameTimer = GetGameTimer

local Config = {
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
