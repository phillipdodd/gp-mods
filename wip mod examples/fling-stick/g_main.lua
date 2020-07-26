function OnTemplate()
    self.RegisterListener(Messager.UsableStarted, FlingStickListener)
    self.RegisterListener(Messager.UsableEnded, UsableEnded)
    World.DropItem(
        "flingstick", 
        1 
    )
    Console.Log("fling-stick loaded")
end

function FlingStickListener(itemID)
    if itemID == "flingstick" then
        self.RegisterListener(Messager.UsableMouseClick, FlingStickClick)
        self.RegisterListener(Messager.UsableInteract, FlingStickInteract)
    end
end

function FlingStickClick()
    World.GetPlayerPosition().Add(Vector3.Multiply())
    local targetVector3 = getPlayerPositionVector3():forward(5)
    setPlayerPositionVector3(targetVector3)
    _G["flingstick.lastTarget"] = targetVector3
    Data.SaveJSON("flingstick.lastTarget", targetVector3:toJSON())
end

function FlingStickInteract()
    local lastTarget = _G["flingstick.lastTarget"]
    if (lastTarget) then
        UI.ShowCornerNotification('Rewinding!')
        setPlayerPositionVector3(lastTarget)
    end
end

function UsableEnded()
    self.UnregisterListener(Messager.UsableInteract)
    self.UnregisterListener(Messager.UsableMouseClick)
end