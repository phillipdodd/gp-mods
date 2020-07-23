Console.DebuggingMods(true)

function OnTemplate()
    self.RegisterListener(Messager.UsableStarted, ApplyUsableListeners)
    self.RegisterListener(Messager.UsableEnded, UsableEnded)
end

function ApplyUsableListeners(itemID)
    if itemID == "yummybugs" then
        self.RegisterListener(Messager.UsableInteract, YummyBugsHandler)
    end
end

function UsableEnded()
    self.UnregisterListener(Messager.UsableInteract)
end

function YummyBugsHandler()
    local currentEnergy = Player.energy
    Player.energy = currentEnergy + 1
    self.ConsumeUsable()
end