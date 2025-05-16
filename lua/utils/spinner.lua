local M = {}
local spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
local should_spin = false
local spinner_idx = 1

local function next_spin()
    spinner_idx = spinner_idx < #spinner and spinner_idx + 1 or 1
    return spinner[spinner_idx]
end

local function loop_spin(message)
    if not should_spin then
        return
    end

    vim.notify("" .. next_spin() .. " " .. message)
    spinner_idx = spinner_idx + 1

    vim.defer_fn(function()
        loop_spin(message)
    end, 125)
end

function M.start(message)
    should_spin = true
    loop_spin(message)
end

function M.stop()
    should_spin = false
    spinner_idx = 1
end

return M
