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

    -- -- get all result
    local entries = vim.iter(jsonData)
        :map(function(item)
            local filename, lineno, colno, message = item:match("^(.+)%((%d+),(%d+)%)%s*:%s*(.+)$")
            return {
                filename = filename,
                lnum = lineno,
                col = colno,
                text = message,
            }
        end)
        :filter(function(item)
            return item.filename ~= nil
        end)
        :totable()

    COMMON_ACTION.setqflist({
        name = "TSC",
        entries = entries,
    })
end

return M
