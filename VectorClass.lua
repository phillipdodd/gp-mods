-- This is obsolete now, including anyway for example of classes
-- see: https://www.gardenpawsgame.com/modding/classes/Utility%20Classes/Vector3/
Vector = {}

function Vector:new(o)
    o = o or {
        __tostring = function(self, v)
            return '{' .. tostring(self[1]) .. ',' .. tostring(self[2]) .. ',' ..tostring(self[3]) .. '}' .. v
        end
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Vector:distanceFrom(targetVector)
    local diffs = {
        diffSquared(self[1], targetVector[1]),
        diffSquared(self[2], targetVector[2]),
        diffSquared(self[3], targetVector[3])
    }
    local sumOfDiffs = sum(diffs)
    return math.sqrt(sumOfDiffs)

end

function DiffSquared(a, b)
    return (a - b)^2
end

function Sum(list)
    local total = 0
    for _, v in pairs(list) do
        total = total + v
    end
    return total
end

function Vector:goBack(n)
    local newVector = Vector:new({})
    newVector[1] = self[1]
    newVector[2] = self[2]
    newVector[3] = self[3] - n
    return newVector
end

function Vector:goForward(n)
    local newVector = Vector:new({})
    newVector[1] = self[1]
    newVector[2] = self[2]
    newVector[3] = self[3] + n
    return newVector
end

function Vector:goDown(n)
    local newVector = Vector:new({})
    newVector[1] = self[1]
    newVector[2] = self[2] - n
    newVector[3] = self[3]
    return newVector
end

function Vector:goUp(n)
    local newVector = Vector:new({})
    newVector[1] = self[1]
    newVector[2] = self[2] + n
    newVector[3] = self[3]
    return newVector
end

function Vector:goLeft(n)
    local newVector = Vector:new({})
    newVector[1] = self[1] - n
    newVector[2] = self[2]
    newVector[3] = self[3]
    return newVector
end

function Vector:goLeft(n)
    local newVector = Vector:new({})
    newVector[1] = self[1] + n
    newVector[2] = self[2]
    newVector[3] = self[3]
    return newVector
end

function GetPlayerPositionVector()
    return Vector:new(World.GetPlayerPosition())
end

function SetPlayerPositionVector(vector)
    return Vector:new(World.SetPlayerPosition(vector))
end

function GetGroundPositionVector(vector, aboveGroundFloat)
    return Vector:new(
        World.GetGroundPosition(vector, aboveGroundFloat)
    )
end

PlayerPosition = GetPlayerPositionVector()
SetPlayerPositionVector(PlayerPosition:goUp(100):goForward(100))
-- groundPosition = getGroundPositionVector(playerPosition, 0.5)

-- for k, v in pairs(groundPosition:goBack(10000):goUp(123123)) do print(k, v) end