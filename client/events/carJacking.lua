local lastcarjack = 0
local timeout = 30 * 1000 --[[ 30 seconds ]]

local GetGameTimer = GetGameTimer

local Config = {
    delay = 10, -- in seconds

    percentage = 10, -- percent chance that the police are informed
}

---get a description of the vehicle
---@param vehicle number
---@return string
function GetVehicleDescription(vehicle)
    if vehicle == 0 then
        return "unknown vehicle"
    end

    local vehdata = GetVehicleInformation(vehicle)

    return ("%s with the plate '%s' of color %s"):format(vehdata.model, vehdata.plate, vehdata.color)
end


-- This only triggers when the dragged person is alive
AddEventHandler('CEventDraggedOutCar', function (victim)

    local gametime = GetGameTimer()
    if lastcarjack > gametime then return end

    if not ShouldNotify(Config.percentage) then return end

    lastcarjack = gametime + timeout

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local street, zone = GetStreetAndAreaFromCoords(coords)

    local gender = IsPedMale(playerPed) and "Man" or "Woman"
    local victimGender = IsPedMale(victim[1]) and "Man" or "Woman"

    local vehicle = GetVehiclePedIsIn(victim[1], true)

    Wait(Config.delay * 1000)

    local data = {
        priority = 'medium',
        code = '10-51',
        title = 'Carjacking',
        description = ('A %s has carjacked a %s from a %s'):format(
            gender,
            GetVehicleDescription(vehicle),
            victimGender
        ),
        location = {
            label = ('%s, %s'):format(street, zone),
            coords = { x = coords.x, y = coords.y }
        },
        time = 300,
        job = 'police',
        fields = {}
    }

    TriggerServerEvent('tablet:dispatch:triggerDispatch', data)
end)