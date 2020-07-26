--! Untested

TicTacToe = {}

function TicTacToe:new()
    local o = {
        activePlayer = "X",
        grid = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}},
        debug = true
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function TicTacToe:toggleActivePlayer()
    if self.activePlayer == "X" then
        self.activePlayer = "O"
    else
        self.activePlayer = "X"
    end
end

function TicTacToe:makeMove(x, y)
    if self.grid[x][y] == 0 then
        self.grid[x][y] = self.activePlayer
        local hasWon = self:checkWinner()
        if hasWon then self:endGame() else
            self:printGrid()
            print('Toggling Active Player...')
            self:toggleActivePlayer()
            return true
        end
    else
        self:handleInvalidMove(x, y)
    end
end

function TicTacToe:handleInvalidMove(x, y) print('[' .. x .. '][' .. y .. '] was an invalid move.') end

function TicTacToe:checkWinner()
    if self.debug then print('Checking if ' .. self.activePlayer .. ' is the winner...') end
    local isWinner = false;
    for i = 1, #self.grid do
        --* Check Columns
        if (
            self.grid[i][1] == self.activePlayer and
            self.grid[i][2] == self.activePlayer and
            self.grid[i][3] == self.activePlayer
        ) then
            isWinner = true
            goto foundWinner
        --* Check Rows
        elseif (
            self.grid[1][i] == self.activePlayer and
            self.grid[2][i] == self.activePlayer and
            self.grid[3][i] == self.activePlayer
        ) then
            isWinner = true
            goto foundWinner
        --* Check Diagonal
        elseif (
            --* "Back Slash"
            (self.grid[1][1] == self.activePlayer and
            self.grid[2][2] == self.activePlayer and
            self.grid[3][3] == self.activePlayer)

            or
            --* "Foward Slash"
            (self.grid[1][3] == self.activePlayer and
            self.grid[2][2] == self.activePlayer and
            self.grid[3][1])
        ) then
            isWinner = true
        end
    end
    ::foundWinner::
    return isWinner;
end

function TicTacToe:endGame()
    print(self.activePlayer .. ' has won!')
end

function TicTacToe:printGrid()
    for _, v in pairs(self.grid) do
        print(v[1], v[2], v[3])
    end
end

