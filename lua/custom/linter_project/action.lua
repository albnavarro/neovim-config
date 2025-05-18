local M = {}
local tree_api = require("nvim-tree.api")
local STATE = require("custom/linter_project/state")

-- Decode job output
function M.decode_output(output)
    -- use pcall to avoid error of parsing
    local success, jsonData = pcall(vim.json.decode, vim.json.encode(output))
    if not success then
        STATE.reset_state_after()
        return false, nil
    end

    return true, jsonData
end

-- check if directory is valid with warning
function M.is_directory_with_warning(path)
    if vim.fn.isdirectory(path) == 0 then
        STATE.reset_state_after()

        -- schedule notify to not append multiple notify
        vim.schedule(function()
            vim.notify("path: " .. path .. " is not valid")
        end)
        return false
    end

    return true
end

-- Open qflist
function M.setqflist(options)
    local name = options.name
    local entries = options.entries

    local is_aborted = STATE.get_aborted()

    if #entries == 0 or is_aborted then
        vim.schedule(function()
            vim.notify(is_aborted and name .. " stop" or "no error found")
        end)

        STATE.reset_state_after()
        vim.cmd.cclose()
        return
    end

    -- Create quilist
    -- vim.fn.setqflist(entries)
    vim.fn.setqflist({}, "r", { title = name, items = entries })
    vim.notify(#entries .. " error found")

    -- Close nvim-tree
    tree_api.tree.close()

    -- Open quilist
    vim.cmd.copen()
    STATE.reset_state_after()
end

return M
