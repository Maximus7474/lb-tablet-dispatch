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

---Get if resource exists and is running
---@param resource string Resource to check
---@return boolean isrunning Is the resource running
function IsResourceValid(resource)
    local state = GetResourceState(resource)
    return state == "started" or state == "starting"
end