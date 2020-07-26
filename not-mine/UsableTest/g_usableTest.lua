--I think Dan Snd wrote this...?

function OnTemplate()
    self.RegisterListener(Messager.UsableStarted,CheckForRightUsable)
end

function CheckForRightUsable(itemID)
    Console.Log(itemID .. " Started")
    -- The item ids are all lower case when they're in the game.
    -- So I have to compare to a all lower case version of it.
    if itemID == "btoast.testusable" then
        self.RegisterListener(Messager.UsableUpdate,Update)
        self.RegisterListener(Messager.UsableInteract,PressedInteract)
        self.RegisterListener(Messager.UsableMouseClick,PressedMouseClick)
        self.RegisterListener(Messager.UsableEnded,Ended)
    end
end

function Update()
    Console.Log("Usable Update");
end

function PressedInteract()
    Console.Log("Pressed Interact");
end

function PressedMouseClick()
    Console.Log("Pressed Mouse Click");
end

function Ended()
    Console.Log("Ended Usable");
    self.UnregisterListener(Messager.UsableUpdate)
    self.UnregisterListener(Messager.UsableInteract)
    self.UnregisterListener(Messager.UsableMouseClick)
    self.UnregisterListener(Messager.UsableEnded)
end