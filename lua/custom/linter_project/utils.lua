local M = {}
local tree_api = require("nvim-tree.api")
local STATE = require("custom/linter_project/state")

-- split vim.system std_out output in a table.
function M.parse_std_out(result)
    return result.stdout and vim.split(result.stdout, "\n") or {}
end

-- split vim.system std_err output in a table.
function M.parse_std_err(result)
    return result.stderr and vim.split(result.stderr, "\n") or {}
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
--- @param options {name: string, entries: LinterProjectEntries|{}}
function M.setqflist(options)
    options = options or {}

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
