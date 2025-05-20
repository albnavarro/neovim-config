local M = {}

--- @param output string[]
--- @return LinterProjectEntries
function M.on_stdout(output)
    return vim.iter(output)
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
end

return M
