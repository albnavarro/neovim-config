local M = {}
local COMMON_ACTION = require("custom/linter_project/action")

function M.on_stdout(output)
    local success, jsonData = COMMON_ACTION.decode_output(output)
    if not success then
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

    COMMON_ACTION.setqflist({
        name = "Stylelint",
        entries = entries,
    })
end

return M
