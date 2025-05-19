local M = {}
local UTILS = require("custom/linter_project/utils")

function M.on_stdout(output)
    -- -- get all result
    local entries = vim.iter(output)
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

    UTILS.setqflist({
        name = "TSC",
        entries = entries,
    })
end

return M
