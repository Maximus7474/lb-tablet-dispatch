function RegisterStandaloneFunctionsAndAddMissingFunctionsIfABridgeIsntBuiltCorrectlyDontAskWhySuchALongFunctionName()
    --[[ These only run in if loops to avoid overwriting and provide default methods to avoid errors ]]
    if not HasJob then
        ---Check if player has a job in the list of jobs
        ---@param jobs string[]|string
        ---@return boolean
        function HasJob(jobs)
            return false
        end
    end
end

SetTimeout(500, RegisterStandaloneFunctionsAndAddMissingFunctionsIfABridgeIsntBuiltCorrectlyDontAskWhySuchALongFunctionName)