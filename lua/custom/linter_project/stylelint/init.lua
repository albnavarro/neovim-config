local M = {}
local UTILS = require("custom/linter_project/utils")

function M.on_stderr(output)
    -- get all result
    local results = vim.iter(output)
        :map(function(item)
            local row_success, row = pcall(vim.json.decode, item)
            if row_success then
                return row
            end

            return {}
        end)
        :flatten()
        :filter(function(item)
            return item.errored == true
        end)
        :totable()

    -- create quilist entries
    local entries = vim.iter(results)
        :map(function(file)
            return vim.iter(file.warnings)
                :map(function(warining)
                    return {
                        filename = file.source,
                        lnum = warining.line,
                        col = warining.column,
                        text = warining.text,
                    }
                end)
                :totable()
        end)
        :flatten()
        :totable()

    UTILS.setqflist({
        name = "Stylelint",
        entries = entries,
    })
end

return M
