local STATE = require("custom/linter_project/state")
local kill_key = "kill current command"

-- Main table, automatic add [idx]
local choices = vim.iter({
    { key = "Eslint", command = "EslintParse" },
    { key = "TSC", command = "TSCParse" },
    { key = "Stylelint", command = "StylelintParse" },
    { key = "DeepCruise", command = "DepcruiseParse" },
    { key = kill_key, command = "Kill" },
})
    :enumerate()
    :map(function(index, item)
        return {
            key = "[" .. index .. "]" .. " " .. item.key,
            command = item.command,
        }
    end)
    :totable()

-- Extract keys for select value
local keys = vim.iter(choices)
    :map(function(item)
        return item.key
    end)
    :totable()

-- Select Command
vim.api.nvim_create_user_command("ProjectCheck", function()
    vim.ui.select(keys, {
        prompt = "ProjectCheck: select command to run",
    }, function(key)
        if not key then
            return
        end

        if string.find(key, kill_key) then
            STATE.kill()
            return
        end

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
