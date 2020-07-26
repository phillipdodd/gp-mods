function onTemplate()
    self.RegisterListener(Messager.UsableStarted, fn_PortalGunListeners)
end
-- portalGunData = {}

function fn_portalGunListeners(itemID)
    if itemID == "phil.item.portalgun" then
        self.RegisterListener(Messager.UsableMouseClick, fn_PortalGunClick)
        -- self.RegisterListener(Messager.UsableUpdate, fn_PortalGunUpdate)
        -- self.RegisterListener(Messager.UsableEnded, fn_PortalGunEnded)
    end 
end

function fn_PortalGunClick()
    Console.Log('test')
    -- local pos = World.GetPlayerPosition()
    -- --* Left Click
    -- if (Input.MouseButtonDown(0)) then
    --     UI.ShowCornerNotification("Left Portal Set!")
    --     portalGunData['leftPortal'] = pos 
        
    -- --* Right Click    
    -- elseif (Input.MouseButtonDown(2)) then
    --     UI.ShowCornerNotification("Right Portal Set!")
    --     portalGunData['rightPortal'] = pos 
    -- end  
end

function fn_PortalGunUpdate()
    if (portalGunData and portalGunData['leftPortal'] and portalGunData[rightPortal]) then 
        local playerPos = World.GetPlayerPosition()
        if (Vector3.Subtract(playerPos, portalgun['leftPortal']) < 2) then 
            World.SetPlayerPosition(portalgun['rightPortal'])
        elseif (Vector3.Subtract(playerPos, portalgun['rightPortal']) < 2) then
            World.SetPlayerPosition(portalgun['leftPortal'])
        end
    end
end

function fn_PortalGunEnded() 
    self.UnregisterFromListener(Messager.UsableMouseClick)
end