
if GetConvarInt('lb-tablet-dispatch:version-check', 1) ~= 1 then return end

local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

if currentVersion:match("^%d+%.%d+%.%d+$") == nil then
    return print('[^1WARNING^7] No current version for the resource, unable to check for updates')
end

PerformHttpRequest("https://api.github.com/repos/Maximus7474/lb-tablet-dispatch/releases/latest", function(err, response, headers)
    if err ~= 200 then
        return
    end

    local data = json.decode(response)
    if not data or not data.tag_name then
        return
    end

    local latestVersion = data.tag_name:gsub("^v", "")

    local latestMajor, latestMinor, latestPatch = (latestVersion):match("^(%d+)%.(%d+)%.(%d+)$")
    local currentMajor, currentMinor, currentPatch = (currentVersion):match("^(%d+)%.(%d+)%.(%d+)$")

    if latestMajor > currentMajor or 
        (latestMajor == currentMajor and latestMinor > currentMinor) or 
        (latestMajor == currentMajor and latestMinor == currentMinor and latestPatch > currentPatch)
    then
        print(string.format("[^5Version Check^7] Update available! Current: %s | Latest: %s", currentVersion, latestVersion))
        print(string.format("[^5Version Check^7] Download here: https://github.com/Maximus7474/lb-tablet-dispatch/releases/tag/v%s", latestVersion))
    else
        print("[^2Version Check^7] You are running the latest version: " .. currentVersion)
    end
 
end, "GET", "", { ["User-Agent"] = "FiveM Script" })
