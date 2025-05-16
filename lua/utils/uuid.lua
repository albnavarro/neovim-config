local M = {}

local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-={}|[]`~"
local charsTable = vim.iter(vim.gsplit(chars, ""))
    :map(function(item)
        return item
    end)
    :totable()

-- Imposta il "seed" per il generatore di numeri pseudo-casuali.
math.randomseed(os.time())

function M.generate()
    return vim.iter(charsTable):fold("", function(previous)
        return previous .. charsTable[math.random(1, 40)]
    end)
end

return M
