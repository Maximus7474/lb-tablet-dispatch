local timeouts = {}

local function canTriggerDispatch(src)
    local gameTime = GetGameTimer()
    if timeouts[src] and timeouts[src] < gameTime then
        timeouts[src] = gameTime
        return true
    elseif not timeouts[src] then
        timeouts[src] = gameTime
        return true
    else
        return false
    end
end

RegisterNetEvent('tablet:dispatch:triggerDispatch', function (data)
    local src = source

    if not canTriggerDispatch(src) then return end

    if type(data.job) == "string" then return exports['lb-tablet']:AddDispatch(data) end

    if type(data.job) == "table" then
        for i = 1, #data.job do
            local nData = data
            nData.job = data.job[i]
            exports['lb-tablet']:AddDispatch(nData)
        end
    end
end)