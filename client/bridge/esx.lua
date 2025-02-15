if not IsResourceValid('es_extended') then return end

local ESX = exports.es_extended:getSharedObject()

--[[ Update player data as export doesn't sync the data ]]
RegisterNetEvent("esx:playerLoaded", function(playerData)
    ESX.PlayerData = playerData
    ESX.PlayerLoaded = true
end)
RegisterNetEvent("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

---Check if player has a job in the list of jobs
---@param jobs string[]|string
---@return boolean
function HasJob(jobs)

    local jobName = ESX.PlayerData.job.name

    if type(jobs) == "string" then
        return jobs == jobName
    end

    for _, v in pairs(jobs) do
        if v == jobName then return true end
    end

    return false
end