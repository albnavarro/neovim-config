local STATE = require("custom/linter_project/state")
local kill_key = "kill current parser"

local choices = {
    { key = "Eslint", command = "EslintParse" },
    { key = "TSC", command = "TSCParse" },
    { key = "DeepCruise", command = "DepcruiseParse" },
    { key = kill_key, command = nil },
}

local keys = vim.iter(choices)
    :map(function(item)
        return item.key
    end)
    :totable()

-- Select Command
vim.api.nvim_create_user_command("ProjectCheck", function()
    vim.ui.select(keys, {
        prompt = "Select command to run",
    }, function(key)
        -- kill current job
        if key == kill_key then
            STATE.kill()
            return
        end

        -- start new job
        local current_choice = vim.iter(choices):find(function(item)
            return item.key == key
        end)

        -- option is not valid
        if not current_choice then
            return
        end

        vim.cmd(current_choice.command)
    end)
end, {})
