DEBUG = true

Config = {
    material = "trophy"
}

function Extend() return "Rabbit" end
function OnTemplate()
    if DEBUG then Console.Log("entities/extendedRabbit.lua OnTemplate() begun") end
    self.setMaterial(Config.material)
    
    self.RegisterListener(Messager.OnEnable, function() Console.Log('enabled') end)
    if DEBUG then Console.Log("entities/extendedRabbit.lua OnTemplate() ended") end
end

function OnClone()
    if DEBUG then Console.Log("entities/extendaRabbit.lua OnClone() begun") end
    

    if DEBUG then Console.Log("entities/extendaRabbit.lua OnClone() ended") end
end
