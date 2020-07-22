function doAtInterval(fn, delay)
    Game.DelayCall(function() 
        fn() 
        return doAtInterval(fn, delay) 
    end, delay)
end