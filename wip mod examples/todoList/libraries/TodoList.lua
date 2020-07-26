if DEBUG then Console.Log("TodoList loaded") end

self.Include('TodoListItem');

TodoList = {}
function TodoList:new()
    if DEBUG then Console.Log("TodoList constructor beginning") end
    local todolist = {
        items = {}
    }
    setmetatable(todolist, self)
    self.__index = self
    return todolist
end

function TodoList:makeUI()

    self.canvas = UI.CreateCanvas(true)
    self.mainPanel = UI.CreatePanel(self.canvas).SetAnchors(0.3, 0.7, 0.1, 0.9)
    UI.CreateImage(self.mainPanel, 1, 1, 1, 1)
    
    
    self:renderTitle(0.1,0.9,0.80,0.95)
    self:renderInputPanel(0.05,0.95,0.15,0.75)
    
    self:renderNewItemButton(0.1,0.9,0.05,0.12)
    self:renderCloseButton(0.9,1,0.9,1)
    
    self.todoItems = self:load()

end

function TodoList:renderTitle(xMin, yMin, xMax, yMax)
    if DEBUG then Console.Log('TodoList:renderTitle() beginning') end
    self.titlePanel = UI.CreatePanel(self.mainPanel).SetAnchors(xMin, yMin, xMax, yMax)
    self.titleText = UI.CreateTextMesh(
        self.titlePanel,
        "Todo List",
        76,0,0.6,0.9,
        1,
        "center",
        "titletext"
    ).SetFont("TitleShadow")
end
    
function TodoList:renderInputPanel(xMin, yMin, xMax, yMax)
    if DEBUG then Console.Log('TodoList:renderInputPanel() beginning') end
    self.inputPanel = UI.CreatePanel(self.mainPanel).SetAnchors(xMin, yMin, xMax, yMax)
end

function TodoList:renderNewItemButton(xMin, yMin, xMax, yMax)
    if DEBUG then Console.Log('TodoList:renderNewItemButton() beginning') end
    self.newItemPanel = UI.CreatePanel(self.mainPanel).SetAnchors(xMin, yMin, xMax, yMax)
    self.newItemButton = UI.AddBlueButton(self.newItemPanel, "New Item", "newItemButton", function () 
        for i = 1, #self.todoItems do
            self.todoItems[i]:toggle()
        end
        -- Console.Log(#self.todoItems)
    end)
    self.newItemButton.rectTransform.SetAnchors(0,1,0,1)
end

function TodoList:renderCloseButton(xMin, yMin, xMax, yMax)
    if DEBUG then Console.Log('TodoList:renderCloseButton() beginning') end
    self.closeButton = UI.AddCloseButton(
        self.mainPanel, 
        "closeButton", 
        function() self.canvas.gameObject.SetActive(false) end
    )
    self.closeButton.rectTransform.SetAnchors(xMin, yMin, xMax, yMax)
end

function TodoList:load()
    if DEBUG then Console.Log('TodoList:load() beginning') end
    --todo make this work with data.load
    local results = {'item one', 'item two', 'item three'}
    local items = {}
    -- if #results < 1 then 
        for i = 1, #results do
            local height = 0.1
            local buffer = 0.05
            local item = TodoListItem:new(self.inputPanel,
                0, 1, 
                1 - ((i - 1) * buffer) - (i / 10), 
                1 - ((i - 1) * buffer) - (i / 10) + height
            )
            -- if DEBUG then Console.Log(item.setText) end
            item:setText(results[i])
            table.insert(items, item)
        end
    -- end

    
    return items
end

function TodoList:save()
    --todo make this work with data.save
    return {}
end


