local lastshot = 0
local timeout = 30 * 1000 --[[ 30 seconds ]]

local GetGameTimer, PlayerPedId = GetGameTimer, PlayerPedId

local Config = {
    delay = 20, -- in seconds

    percentage = 60, -- percent chance the police should be notified

    excludedWeapons = { -- Won't trigger notifications
        [`WEAPON_STUNGUN`] = true,
        [`WEAPON_STUNGUN_MP`] = true,
        [`WEAPON_BALL`] = true,
        [`WEAPON_SNOWBALL`] = true,
    },

    weaponCode = {
        default = "10-13"
    },

    copsCanTrigger = false,
    policeJobs = {"police"},
}

AddEventHandler('CEventGunShot', function (hits)
    --[[ hits: string[] -- entities hit by the bullet ? ]]

    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then return end

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
        description = ('Shots coming from a %s have been reported'):format(GetWeaponLabel(weaponHash)),
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
