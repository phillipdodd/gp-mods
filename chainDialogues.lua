function OnTemplate() 
    UI.AddMenuButton('button', makeDialog)
end

function makeDialog(data)
    local data = data or {}
    Dialog.ShowInputDialog(
        "Store Data",
        "Enter a Thing",
        "",
        10,
        function(input)
            table.insert(data, input)
            Game.DelayCall(makeDialog, 0.5, data)
        end,
        function(input)
            for k, v in pairs(data) do Console.Log(v) end
            return
        end
    );
end

makeDialog({})