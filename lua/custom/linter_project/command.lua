local STATE = require("custom/linter_project/state")
local CONFIG = require("custom/linter_project/config")
local JOB = require("custom/linter_project/job")

--- Main table, automatic add [idx]
--- @type LinterProjectConfig
local choices = vim.iter(CONFIG.config)
    :enumerate()
    :map(function(index, item)
        return {
            key = "[" .. index .. "]" .. " " .. item.key,
            options = item.options,
        }
    end)
    :totable()

--- Extract keys for select value
--- @type string[]
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

        if string.find(key, CONFIG.kill_key) then
            STATE.kill()
            return
        end

        --- @type {key: string, options?: LinterProjectConfigOptions}
        local current_choice = vim.iter(choices):find(function(item)
            return item.key == key
        end)

        -- option is not valid
        if not current_choice then
            return
        end

        JOB.start(current_choice.options)
    end)
end, {})
