Account = {}
function Account:new()
    local newAccount = {}
    self.__index = self
    setmetatable(newAccount, self)
    return newAccount
end

SpecialAccount = {}
function SpecialAccount:new()
    local newSpecialAccount = {}
    self.__index = Account
    setmetatable(newSpecialAccount, self)
    return newSpecialAccount
end

x = SpecialAccount:new()
x:deposit(2)
print(x.balance)