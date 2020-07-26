-- author's discord name: noircchack
function OnTemplate()
    self.RegisterListener(Messager.UsableStarted,CheckForRightUsable)
end

function CheckForRightUsable(itemID)
    --Console.Log(itemID .. " Started")
    -- The item ids are all lower case when they're in the game.
    -- So I have to compare to a all lower case version of it.
    if itemID == "pinktrashcat_items_orb" then
        self.RegisterListener(Messager.UsableUpdate,Update)
        self.RegisterListener(Messager.UsableInteract,PressedInteract)
--        self.RegisterListener(Messager.UsableMouseClick,PressedMouseClick)
        self.RegisterListener(Messager.UsableEnded,Ended)
		
		UI.AddInteractUI("R","Start Time")
		UI.AddInteractUI("Q","Stop Time")
		UI.AddInteractUI("X","Change Time")
		UI.AddInteractUI("H","Reset Time")
    end
end

function Update()
   --UI.ShowCornerNotification("Usable Update");
   -- All sec. when object is selected
   
	if Input.GetKey(KeyCode.R) then StartTime() end
	if Input.GetKey(KeyCode.Q) then StopTime() end
	if Input.GetKey(KeyCode.X) then ChangeTime() end
	if Input.GetKey(KeyCode.H) then ResetTime() end
end

function PressedInteract()
    --UI.ShowCornerNotification("Pressed Interact");
	-- When E is press
end

function PressedMouseClick()
    --UI.ShowCornerNotification("Pressed Mouse Click");
	-- when the mouse click is pressed
end

function Ended()
	-- When object is deselected
    UI.ShowCornerNotification("Ended Usable");
    self.UnregisterListener(Messager.UsableUpdate)
    self.UnregisterListener(Messager.UsableInteract)
--    self.UnregisterListener(Messager.UsableMouseClick)
    self.UnregisterListener(Messager.UsableEnded)
	UI.ClearInteractUIs()
end

function StartTime()
    Clock.SetMinuteDuration(1)
    Console.log("fn_mb_StartTime function loaded")
    UI.ShowCornerNotification("Time Started")
end

function StopTime()
    Clock.SetMinuteDuration(9999)
    Console.log("fn_mb_StopTime function loaded")
    UI.ShowCornerNotification("Time Stopped")
end

function ChangeTime()
	Clock.SetDayTime(12,01)
    UI.ShowCornerNotification("Time changed")	
end

function ResetTime()
	Clock.SetDayTime(6,01)
    UI.ShowCornerNotification("Time reseted")
end