if DEBUG then Console.Log("Helpers Loaded") end
function doAtInterval(fn, delay)
    Game.DelayCall(function() 
        fn() 
        return doAtInterval(fn, delay) 
    end, delay)
end