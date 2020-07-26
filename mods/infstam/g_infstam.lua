function onTemplate() 
    self.RegisterGlobalFunction("resetStaminaUntil", resetStaminaUntil)
    self.RegisterGlobalFunction("ping", function() Console.Log('pong') end)
end

function doUntil(doFn, duration)
    local startTime = Clock.CurrentTimeFromEver()
    self.CallGlobalFunction(RegisterListener, Messager.SlowUpdate, doFn)
    self.DelayCall(function() 
        self.CallGlobalFunction(UnregisterListener, Messager.SlowUpdate)
    end, duration)
end

function resetStaminaUntil(duration)
    doUntil(function() Player.stamina = Player.maxStamina end, duration)
end



