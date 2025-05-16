-- Test: try object oriented basic
local M = {
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-={}|[]`~",
    lenght = 40,
}

-- Imposta il "seed" per il generatore di numeri pseudo-casuali.
math.randomseed(os.time())

function M.generate(self)
    local charsTable = vim.iter(vim.gsplit(self.chars, "")):totable()

    return vim.iter(charsTable):fold("", function(previous)
        return previous .. charsTable[math.random(1, self.lenght)]
    end)
end

return M

-- `:` -> implicit pass `self` to generate() method
--
-- then:
-- current_instance_id = UUID:generate()
