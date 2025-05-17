local M = {}
local tree_api = require("nvim-tree.api")
local STATE = require("custom/linter_project/state")

function M.setqflist(options)
    local name = options.name
    local entries = options.entries

    local is_aborted = STATE.get_aborted()

    if #entries == 0 or is_aborted then
        vim.schedule(function()
            vim.notify(is_aborted and name .. " stop" or "no error found")
        end)

        STATE.set_active(false)
        vim.cmd.cclose()
        return
    end

    -- vim.print(vim.inspect(entries))

    -- Create quilist
    -- vim.fn.setqflist(entries)
    vim.fn.setqflist({}, "r", { title = "TSC", items = entries })
    vim.notify(#entries .. " error found")

    -- Close nvim-tree
    tree_api.tree.close()

    -- Open quilist
    vim.cmd.copen()
    STATE.set_active(false)
end

M.find_bin_in_node_modules = function(name)
    local node_modules_binary = vim.fn.findfile("node_modules/.bin/" .. name, ".;")

    if node_modules_binary ~= "" then
        return node_modules_binary
    end

    return name
end

return M
