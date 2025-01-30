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

    exports['lb-tablet']:AddDispatch(data)
end)