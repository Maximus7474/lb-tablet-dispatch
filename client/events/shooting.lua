local lastshot = 0
local timeout = 30 * 1000 --[[ 30 seconds ]]

local GetGameTimer = GetGameTimer

local Config = {
    delay = 30, -- in seconds

    excludedWeapons = { -- Won't trigger notifications
        [`WEAPON_STUNGUN`] = true,
        [`WEAPON_STUNGUN_MP`] = true,
        [`WEAPON_BALL`] = true,
        [`WEAPON_SNOWBALL`] = true,
    },

    weaponCode = {
        default = "10-13"
    },

    copsCanTrigger = true,
    policeJobs = {"police"},
}

local WeaponNames = {
    [`WEAPON_COMBATPISTOL`] = "Pistol",
    [`WEAPON_PISTOL`] = "Pistol",
    [`WEAPON_PISTOL_MK2`] = "Pistol Mk2",
    [`WEAPON_APPISTOL`] = "AP Pistol",
    [`WEAPON_SMG`] = "SMG",
    [`WEAPON_ASSAULTRIFLE`] = "Assault Rifle",
    [`WEAPON_ASSAULTRIFLE_MK2`] = "Assault Rifle Mk2",
    [`WEAPON_CARBINERIFLE`] = "Carbine Rifle",
    [`WEAPON_CARBINERIFLE_MK2`] = "Carbine Rifle Mk2",
    [`WEAPON_BULLPUPRIFLE`] = "Bullpup Rifle",
    [`WEAPON_BULLPUPRIFLE_MK2`] = "Bullpup Rifle Mk2",
    [`WEAPON_SNIPERRIFLE`] = "Sniper Rifle",
    [`WEAPON_HEAVYSNIPER`] = "Heavy Sniper",
    [`WEAPON_HEAVYSNIPER_MK2`] = "Heavy Sniper Mk2",
    [`WEAPON_SHOTGUN`] = "Shotgun",
    [`WEAPON_AUTOSHOTGUN`] = "Assault Shotgun",
    [`WEAPON_PUMPSHOTGUN`] = "Pump Shotgun",
    [`WEAPON_SAWNOFFSHOTGUN`] = "Sawed-Off Shotgun",
    [`WEAPON_MUSKET`] = "Musket",
    [`WEAPON_RPG`] = "RPG",
    [`WEAPON_GRENADELAUNCHER`] = "Grenade Launcher",
    [`WEAPON_MINIGUN`] = "Minigun",
    [`WEAPON_FIREEXTINGUISHER`] = "Fire Extinguisher",
    [`WEAPON_STICKYBOMB`] = "Sticky Bomb",
    [`WEAPON_MOLOTOV`] = "Molotov Cocktail",
    [`WEAPON_BOTTLE`] = "Broken Bottle",
    [`WEAPON_FLAREGUN`] = "Flare Gun",
    [`WEAPON_VINTAGEPISTOL`] = "Vintage Pistol",
    [`WEAPON_MARKSMANRIFLE`] = "Marksman Rifle",
    [`WEAPON_MARKSMANRIFLE_MK2`] = "Marksman Rifle Mk2",
}

AddEventHandler('CEventGunShot', function (hits)
    --[[ hits: string[] -- entities hit by the bullet ? ]]

    if not Config.copsCanTrigger and HasJob(Config.policeJobs) then return end

    local playerPed = PlayerPedId()

    local retval, weaponHash = GetCurrentPedWeapon(playerPed, true)
    if not retval then return end

    local gametime = GetGameTimer()
    if lastshot > gametime then return end
    lastshot = gametime + timeout

    if Config.excludedWeapons[weaponHash] then return end

    local coords = GetEntityCoords(playerPed)
    local street, zone = GetStreetAndAreaFromCoords(coords)

    Wait(Config.delay * 1000)

    local data = {
        priority = 'high',
        code = Config.weaponCode.default,
        title = 'Shots fired',
        description = ('Shots coming from %s have been reported'):format(WeaponNames[weaponHash]),
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
