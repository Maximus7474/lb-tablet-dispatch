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
