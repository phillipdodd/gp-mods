if DEBUG then Console.Log("TodoListItem loaded") end

TodoListItem = {}

function TodoListItem:new(parentPanel, xMin, yMin, xMax, yMax)
    if DEBUG then Console.Log('TodoListItem:new() beginning') end
    local todoListItem = {}
    todoListItem.text = "Todo Item Text"
    todoListItem.panel = UI.CreatePanel(parentPanel).SetAnchors(xMin, yMin, xMax, yMax)
    -- UI.CreateImage(todoListItem.panel, 1, 1, 1, 0.8)
    todoListItem.inputField = UI.CreateInputField(todoListItem.panel)
    todoListItem.textField = UI.CreateTextMesh(
        todoListItem.panel,
        "",
        18,0,0,0,
        1,
        "left",
        "listitemtext"
    )
    local text = "Insert Todo List Item Here";
    todoListItem.text = text
    todoListItem.textField.text = text
    todoListItem.inputField.placeholderText = text

    todoListItem.inputShowing = false
    todoListItem.inputField.gameObject.SetActive(false)
    todoListItem.textShowing = true
    todoListItem.textField.gameObject.SetActive(true)

    setmetatable(todoListItem, self)
    self.__index = self
    return todoListItem
end

function TodoListItem:setText(text)
    if DEBUG then Console.Log('TodoListItem:setText() beginning') end
    self.text = text
    self.textField.text = text
    self.inputField.placeholderText = text
end

function TodoListItem:toggle()
    if DEBUG then Console.Log("TodoListItem:toggle() beginning") end
    self.inputShowing = not self.inputShowing
    self.textShowing = not self.textShowing
    self.inputField.gameObject.SetActive(self.inputShowing)
    self.textField.gameObject.SetActive(self.textShowing) 
end