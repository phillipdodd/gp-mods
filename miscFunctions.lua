function limitedListener(message, fn, n)
    -- Init limitedListeners table if does not exist
    if limitedListeners == nil or type(limitedListeners) ~= 'table' then
        limitedListeners = {}
    end

    local countKey = tostring(fn)
    limitedListeners[countKey] = n
    
    self.RegisterListener(message, function ()
        local countKey = countKey
        local count = limitedListeners[countKey];
        if count > 0 then
            fn()
            limitedListeners[countKey] = count - 1
        else
            self.UnregisterListener(message, fn)
            fn = nil
            limitedListeners[countKey] = nil
        end
    end)
end

function delayCallback(fn, ...) 
    local timeStart = os.clock();
    return fn(table.unpack({...}))
end

function makeFnLogger(prefix)
    return function(x)
        x = x or 'nil'
        Console.Log(prefix .. x)
    end
end

--* param {table} table - the table to map over
--* param {function} fn - the function to be executed. will be passed the key and value
--* OPTIONAL param {function} filterFn - will only process values that return true when passed into this function
function mapTable(table, fn, filterFn)
    for k, v in pairs(table) do
        if filterFn and filterFn(v) == true then 
            fn(k,v)
        end
    end
end

function listenOnce(message, fn)
    function listener() 
        fn()
        Console.Log('unregistering ' .. tostring(listener))
        self.UnregisterListener(message, listener)
    end
    Console.Log('registering ' .. tostring(listener))
    self.RegisterListener(message, listener)
end