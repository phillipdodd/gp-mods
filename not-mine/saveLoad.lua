--author: Dan Snd (i think)

function save(v) 
    stuff = {}
    stuff['test'] = 'hello world'
    valueToSave = json.serialize(stuff)
    Data.SaveJSON('stuff', v)
end

function TestLoading() 
    stuff = {}
    -- Adding some default value so when I retrieve I can still check for it
    stuff['test'] = 'save not found'
    defaultStuff = json.serialize(stuff)
    loadStuff = Data.LoadJSON('stuff', defaultStuff)
    Console.Log(loadStuff)
    newStuff = json.parse(loadStuff)
    Console.Log(newStuff['test'])
end