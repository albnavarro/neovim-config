local M = {}
local tree_api = require("nvim-tree.api")
local STATE = require("custom/eslint/state")

function M.on_stdout_callback(data)
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

    -- vim.print(vim.inspect(entries))

    local is_aborted = STATE.get_aborted()

    if #entries == 0 or is_aborted then
        vim.schedule(function()
            vim.notify(is_aborted and "Eslint stop" or "no error found")
        end)

        STATE.set_active(false)
        vim.cmd.cclose()
        return
    end

    -- vim.print(vim.inspect(entries))

    -- Create quilist
    -- vim.fn.setqflist(entries)
    vim.fn.setqflist({}, "r", { title = "ESLINT", items = entries })
    vim.notify(#entries .. " error found")

    -- Close nvim-tree
    tree_api.tree.close()

    -- Open quilist
    vim.cmd.copen()
    STATE.set_active(false)
end

return M
