local M = {}
local COMMON_ACTION = require("custom/linter_project/action")

function M.on_stdout(output)
    local success, jsonData = COMMON_ACTION.decode_output(output)
    if not success then
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
