function mapTable(t, fn)
    
    local i = 0
    local function createIterator(t) 
        return function() 
            i = i + 1
            -- into callback is passed: table itself, current value, current index
            return t[i] and fn(t, t[i], i)
        end
    end

    local result = {}
    local iter = createIterator(t)
    for val in iter do
        if (val) then 
            table.insert(result, val)
        end
    end

    return result
end

originalTable = {1,2,3}
mappedTable = mapTable(
    originalTable, 
    function(_, v) 
        return v * 2 
    end
)

function printTableValues(t)
    for _, v in pairs(t) do print(v) end 
end

printTableValues(originalTable)
-- 1
-- 2
-- 3

printTableValues(mappedTable)
-- 2
-- 4
-- 6