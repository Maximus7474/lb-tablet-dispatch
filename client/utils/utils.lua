---Get Street and Zone name from coordinates
---@param coords vector3|{x:number,y:number,z:number}
---@return string streetName
---@return string areaName
function GetStreetAndAreaFromCoords(coords)
    local x, y, z = coords.x, coords.y, coords.z
    local streetHash = GetStreetNameAtCoord(x, y, z)
    local streetName = GetStreetNameFromHashKey(streetHash)

    local areaName = GetNameOfZone(x, y, z)

    return streetName, areaName
end

---Random check, should police be informed based on a tolerance value
---@param tolerance number number between 0 and 100 inclusive
---@return boolean notify did the random math stuff think it's time to call em ?
function ShouldNotify(tolerance)
    if type(tolerance) ~= "number" then return false end
    if tolerance <= 0 then return false end
    if tolerance >= 100 then return true end

    tolerance = math.max(0, math.min(100, tolerance))
    return math.random(0, 100) <= tolerance
end

---Get if resource exists and is running
---@param resource string Resource to check
---@return boolean isrunning Is the resource running
function IsResourceValid(resource)
    local state = GetResourceState(resource)
    return state == "started" or state == "starting"
end