local M = {}
local STATE = require("custom/linter_project/state")
local COMMON_ACTION = require("custom/linter_project/action")

function M.on_stdout(data)
    -- use pcall to avoid error of parsing
    local success, jsonData = pcall(vim.json.decode, vim.json.encode(data))
    if not success then
        STATE.set_active(false)
        return
    end

    -- get all result
    local results = vim.iter(jsonData)
        :map(function(item)
            local row_success, row = pcall(vim.json.decode, item)
            if row_success then
                return row
            end

            return {}
        end)
        :flatten()
        :filter(function(item)
            return item.errorCount > 0
        end)
        :totable()

    -- create quilist entries
    local entries = vim.iter(results)
        :map(function(file)
            return vim.iter(file.messages)
                :map(function(error)
                    return {
                        filename = file.filePath,
                        lnum = error.line,
                        col = error.column,
                        text = error.message,
                    }
                end)
                :totable()
        end)
        :flatten()
        :totable()

    COMMON_ACTION.setqflist({
        name = "ESlint",
        entries = entries,
    })
end

return M
