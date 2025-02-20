if not IsResourceValid('qbx_core') then return end

---@param jobs string[]|string
---@return boolean
function HasJob(job)
    local playerGroups = exports.qbx_core:GetGroups()

    if type(jobs) == "string" then
        return playerGroups[job] ~= nil
    end

    for _, v in pairs(jobs) do
        if playerGroups[v] then
            return true
        end
    end

    return false
end