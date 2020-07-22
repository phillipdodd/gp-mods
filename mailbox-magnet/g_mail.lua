-- Just for fun, not recommended lol
positions = {
    mailbox = {502, 10, 570}
}

function getCurrentDirToMailbox()
    return Vector3.DirFrom(World.GetPlayerPosition(), POSITIONS.mailbox)
end

function mailboxMagnet()
    local directionToMailbox = Vector3.DivideNumber(getCurrentDirToMailbox(), 2)
    local playerPosition = World.GetPlayerPosition()
    World.SetPlayerPosition(
        Vector3.Add(playerPosition, directionToMailbox)
    )
end

function doAtInterval(fn, delay)
    Game.DelayCall(function() 
        fn() 
        return doAtInterval(fn, delay) 
    end, delay)
end