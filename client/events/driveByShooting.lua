local lastshot = 0
local timeout = 30 * 1000 --[[ 30 seconds ]]

local GetGameTimer, PlayerPedId = GetGameTimer, PlayerPedId

local Config = {
    delay = 10, -- in seconds

    percentage = 55, -- percent chance the police should be notified

    excludedWeapons = { -- Won't trigger notifications
        [`WEAPON_STUNGUN`] = true,
        [`WEAPON_STUNGUN_MP`] = true,
        [`WEAPON_BALL`] = true,
        [`WEAPON_SNOWBALL`] = true,
    },

    weaponCode = {
        default = "10-23"
    },

    copsCanTrigger = true,
    policeJobs = {"police"},
}

local function GetVehicleDescription(vehicle)
    if vehicle == 0 then
        return "unknown vehicle"
    end

    local vehdata = GetVehicleInformation(vehicle)

    return ("a vehicle of model %s with the plate '%s' and %s colour"):format(vehdata.model, vehdata.plate, vehdata.color)
end

AddEventHandler('CEventGunShot', function (hits)
    --[[ hits: string[] -- entities hit by the bullet ? ]]

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if not IsPedInAnyVehicle(playerPed, false) or not DoesEntityExist(vehicle) then return end

    if not Config.copsCanTrigger and HasJob(Config.policeJobs) then return end


    local retval, weaponHash = GetCurrentPedWeapon(playerPed, true)
    if not retval then return end

    local gametime = GetGameTimer()
    if lastshot > gametime then return end

    if not ShouldNotify(Config.percentage) then return end

    lastshot = gametime + timeout

    if Config.excludedWeapons[weaponHash] then return end

    local coords = GetEntityCoords(playerPed)
    local street, zone = GetStreetAndAreaFromCoords(coords)

    Wait(Config.delay * 1000)

    local data = {
        priority = 'high',
        code = Config.weaponCode.default,
        title = 'Shots fired',
        description = ('Shots from a %s have been fired from %s'):format(GetWeaponLabel(weaponHash), GetVehicleDescription(vehicle)),
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
