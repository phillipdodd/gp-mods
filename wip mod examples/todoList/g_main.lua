DEBUG = true

self.Include("Helpers")
self.Include("TodoList")

Panels = {}

function OnTemplate()
    -- if DEBUG then Console.Log("OnTemplate beginning") end
    -- local todo = TodoList:new()
    -- table.insert(Panels, todo:makeUI())
    -- if DEBUG then Console.Log("TodoList Created") end
    -- doAtInterval(function() 
    --     for i, _ in ipairs(Panels) do table.remove(Panels, i) end
    -- end, 5)
end
