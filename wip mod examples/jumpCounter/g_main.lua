--! Untested

function OnTemplate()
    sharedData = {}
    sharedData.jumps = 0
    -- self.RegisterListener(Messenger.FiveSecondsIntoDay, function()
    --     Clock.setMinuteDuration(9999)
    -- end)
    self.ListenForNetworkCalls();
    self.RegisterListener(Messager.PlayerJumped, function()
        self.CallFunctionOnEveryone("IncrementJumpCount", nil)
    end)
end

function IncrementJumpCount()
    sharedData['jumps'] = sharedData['jumps'] + 1;
    Console.Log(sharedData['jumps'])
end