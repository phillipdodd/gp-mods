Console.DebuggingMods(true)

function OnTemplate()
    self.RegisterListener(Messenger.UsableStarted, ApplyUsableListeners)
    self.RegisterListener(Messenger.UsableEnded, UsableEnded)
end

function ApplyUsableListeners(itemID)
    if itemID == "timebottle" then
        self.RegisterListener(Messenger.UsableInteract, TimeBottleUsableInteract)
        self.RegisterListener(Messenger.UsableMouseClick, TimeBottleUsableMouseClick)
    end
end

function UsableEnded()
    self.UnregisterListener(Messenger.UsableInteract)
    self.UnregisterListener(Messenger.UsableMouseClick)
end

function TimeBottleUsableInteract()
    local title = "Time Bottle"
    local message = "Do you want to bottle the rest of your day?"
    Dialog.ShowYesNoDialog(
        title, 
        message, 
        BottleTime, 
        function() 
            UI.ShowCornerNotification("You decide not to bottle any time.")
        end
    )
end

function TimeBottleUsableMouseClick()
    local minutes = Data.LoadNumber('timebottleminutes')
    UI.ShowCornerNotification("You've bottled " .. minutes/60 .. " hours!")
end

function BottleTime()
    local minutesToBottle = GetMinutesLeftInDay()
    local savedMinutes = Data.LoadNumber('timebottleminutes')
    Data.SaveNumber('timebottleminutes', minutesToBottle + savedMinutes) 
    UI.ShowCornerNotification("You stuff " .. minutesToBottle / 60 .. " hours into your bottle and you feel time begin to slip away from you.")
    Clock.SetMinuteDuration(.001)
    self.RegisterListener(Messenger.DayEnded, function()
        Clock.SetMinuteDuration(1)
        self.UnregisterListener(Messenger.DayEnded)
    end) 
end

function GetMinutesLeftInDay()
    local minutes = 60 - Clock.CurrentMinute()
    local hours = 24 - Clock.CurrentHour()
    return minutes + (hours * 60);
end

print(GetMinutesLeftInDay())