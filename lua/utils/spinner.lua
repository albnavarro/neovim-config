local M = {}
local UUID = require("utils/uuid")
local spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
local should_spin = false
local spinner_idx = 1
local current_instance_id = ""

local function next_spin()
    spinner_idx = spinner_idx < #spinner and spinner_idx + 1 or 1
    return spinner[spinner_idx]
end

local function loop_spin(options)
    local message = options.message
    local id = options.id

    -- spinner is a `singleton`.
    -- stop current loop if new current_instance_id change or stop() is fired.
    if not should_spin or current_instance_id ~= id then
        return
    end

    vim.notify("" .. next_spin() .. " " .. message)
    spinner_idx = spinner_idx + 1

    vim.defer_fn(function()
        loop_spin(options)
    end, 125)
end

function M.start(message)
    should_spin = true
    current_instance_id = UUID.generate()
    loop_spin({ message = message, id = current_instance_id })
end

function M.stop()
    should_spin = false
    spinner_idx = 1
end

-- M.start("pippo")
--
-- vim.defer_fn(function()
--     M.start("pippo 2")
-- end, 1200)

return M
