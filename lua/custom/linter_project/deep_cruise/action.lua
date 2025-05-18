local M = {}
local COMMON_ACTION = require("custom/linter_project/action")

function M.on_stdout(output)
    local success, jsonData = COMMON_ACTION.decode_output(output)
    if not success then
        return
    end

    -- -- get all result
    local results = vim.iter(jsonData)
        :map(function(item)
            local string_to_parse = vim.split(item, ":")

            return vim.iter(string_to_parse)
                :map(function(string)
                    return string:gsub("%s+", ""):gsub("→", "")
                end)
                :rev()
                :totable()
        end)
        :filter(function(item)
            return #item == 2
        end)
        :map(function(item)
            return vim.iter(item)
                :map(function(row)
                    return row[1]
                end)
                :totable()
        end)
        :totable()

    -- create quilist entries
    local entries = vim.iter(results)
        :map(function(item)
            return {
                filename = item[1],
                lnum = "-",
                col = "-",
                text = item[2],
            }
        end)
        :totable()

    COMMON_ACTION.setqflist({
        name = "depcruise",
        entries = entries,
    })
end

return M
