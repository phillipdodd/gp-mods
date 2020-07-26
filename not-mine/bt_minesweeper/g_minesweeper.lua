--author: Daniel Snd
--see https://www.gardenpawsgame.com/modding/Examples/Advanced/exampleMinesweeper/
function OnTemplate()
    CreateUI()
    self.RegisterListener(Messager.StartGameUI,MakeUIOpenButton)
end

function MakeUIOpenButton()
    UI.AddMenuButton("Minesweeper",OpenUI)
end

mineSweeper = {}

function CreateUI()
    myCanvas = UI.CreateCanvas(true)
    mainPanel = UI.CreatePanel(myCanvas).SetAnchors(0.3, 0.7, 0.1, 0.9)
    UI.CreateImage(mainPanel,1,1,1,0.8)
    titlePanel = UI.CreatePanel(mainPanel).SetAnchors(0.1,0.9,0.80,0.95)
    titleText = UI.CreateTextMesh(titlePanel, "Minesweeper",48,0,0.7,1,1,"center","titletext").SetFont("TitleShadow")
    buttonsPanel = UI.CreatePanel(mainPanel).SetAnchors(0.19,0.82,0.05,0.78)
    buttonsGrid = UI.CreateGridLayout(buttonsPanel,32,32,"bgrid")
    for i=0,129 do
        SetupCell(i)
    end
    ResetCells()
    resetPanel = UI.CreatePanel(mainPanel).SetAnchors(0.8,0.9,0.9,1)
    -- Creates a new button in the buttons panel without any callback since it's going to be set by our entity.
    resetButton = UI.AddBlueButton(resetPanel,"R", "buttons",ResetCells)
    -- Makes our button the size of our panel.
    resetButton.rectTransform.SetAnchors(0,1,0,1)

    -- Adds a close button to the main panel which will call our CloseUI function.
    closeButton = UI.AddCloseButton(mainPanel, "closeButton", CloseUI)
    -- Sets the anchors of the close button's rect transform to the right corner.
    closeButton.rectTransform.SetAnchors(0.9,1,0.9,1)
    CloseUI()
end

function OpenUI()
    Game.UnpauseGame()
    myCanvas.gameObject.SetActive(true)
end
function CloseUI()
    myCanvas.gameObject.SetActive(false)
    Game.PauseGame()
end

function ResetCells()
    titleText.text = "Minesweeper"
    for k, v in pairs(mineSweeper) do
       v["Button"].image.sprite = UI.GetSprite("btms_unkn")
       v["Revealed"] = false   
        if(math.random() < 0.15) then
            v["IsMine"] = true
            else
            v["IsMine"] = false
        end
    end
end

function SetupCell(i)
    local mineSweeperInfo = {}
    mineSweeperInfo["ID"] = i
    mineSweeperInfo["row"] = math.floor(i / 10)
    mineSweeperInfo["col"] = i % 10
    local newButton = UI.AddBlueButton(buttonsPanel,"", "buttons", ClickedCell,i)
    mineSweeperInfo["Button"] = newButton
    mineSweeper[i] = mineSweeperInfo
end

function ClickedCell(n)
    if(mineSweeper[n]["Revealed"] == false) then
        if(mineSweeper[n]["IsMine"] == true) then
            GameOver()
        else
            RevealCell(n)
            visited = {}
            FloodFillReveal(mineSweeper[n]["row"],mineSweeper[n]["col"])

            if(CheckIsDone() == true) then
                Win()
            end
        end
    end
end

function RevealCell(n)
    if mineSweeper[n] == nil then return false end
    mineSweeper[n]["Revealed"] = true
    if  (mineSweeper[n]["IsMine"]) then
        mineSweeper[n]["Button"].image.sprite = UI.GetSprite("btms_b")
        else
        mineSweeper[n]["Button"].image.sprite = UI.GetSprite("btms_" .. CountAdj(n))
    end
end

function GameOver()
    mainPanel.transform.DOShakeScale(1,0.2)
    titleText.text = "<color=#ff0000>GAME OVER</color>"
    -- Reveal all mines
    for k, v in pairs(mineSweeper) do
        if(v["IsMine"] == true) then
            v["Button"].image.sprite = UI.GetSprite("btms_b")
        end
     end
end

function Win()
    mainPanel.transform.DOShakeScale(1,0.2)
    titleText.text = "<color=#00FF00>VICTORY!</color>"
end

function GetCellID(x,y)
    for k, v in pairs(mineSweeper) do
       if(v["row"] == x and v["col"] == y) then
        return v["ID"]
       end
    end
end

function IsMine(x,y)
    for k, v in pairs(mineSweeper) do
        if(v["row"] == x and v["col"] == y) then
            return v["IsMine"]
        end
    end
end

function CountAdj(n)
    local adjCount = 0
        x = mineSweeper[n]["row"]
        y = mineSweeper[n]["col"]
        if (IsMine(x,   y+1)) then adjCount = adjCount + 1 end --  top
        if (IsMine(x+1, y+1)) then adjCount = adjCount + 1 end --  top-right
        if (IsMine(x+1, y  )) then adjCount = adjCount + 1 end --  right
        if (IsMine(x+1, y-1)) then adjCount = adjCount + 1 end --  bottom-right
        if (IsMine(x,   y-1)) then adjCount = adjCount + 1 end --  bottom
        if (IsMine(x-1, y-1)) then adjCount = adjCount + 1 end --  bottom-left
        if (IsMine(x-1, y  )) then adjCount = adjCount + 1 end --  left
        if (IsMine(x-1, y+1)) then adjCount = adjCount + 1 end --  top-left

    return adjCount
end

function FloodFillReveal(x,y)
    if(visited[x..y] ~= nil) then
        return false
    else
        local cellId = GetCellID(x,y)
        if(cellId ~= nil) then
            RevealCell(cellId)
            
            visited[x..y] = true

            -- If found something around already stop.
            if(CountAdj(cellId) > 0) then
                return true
            end

            FloodFillReveal(x-1, y);
            FloodFillReveal(x+1, y);
            FloodFillReveal(x, y-1);
            FloodFillReveal(x, y+1);
        end
    end
end

function CheckIsDone()
    for k, v in pairs(mineSweeper) do
        if(v["Revealed"] == false and v["IsMine"] == false) then
            return false
        end
    end
    return true
end