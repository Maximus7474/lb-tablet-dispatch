local ESX = exports.es_extended:getSharedObject()

---Get the player's character identifier
---@return string|nil
function GetIdentifier()
    return ESX.PlayerData.identifier
end

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