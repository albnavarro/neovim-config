local M = {}

local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-={}|[]`~"
local lenght = 40
local charsTable = vim.iter(vim.gsplit(chars, "")):totable()

-- Imposta il "seed" per il generatore di numeri pseudo-casuali.
math.randomseed(os.time())

function M.generate()
    return vim.iter(charsTable):fold("", function(previous)
        return previous .. charsTable[math.random(1, lenght)]
    end)
end

return M
