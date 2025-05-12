local U = require("utils/tables_utils")
local treeApi = require("nvim-tree.api")

local on_out = function(data)
    -- vim.notify(vim.inspect(data))

    -- Filter file from result
    local filnames = U.filter(data, function(item)
        return (vim.uv.fs_stat(item) or {}).type == "file"
    end)

    -- Prepare quilist entries
    local entries = U.map(filnames, function(item)
        return { filename = item }
    end)

    -- Create quilist
    vim.fn.setqflist(entries)

    -- Close nvim-tree
    treeApi.tree.close()

    -- Open quilist
    vim.cmd.copen()
end

vim.api.nvim_create_user_command("EslintRun", function()
    local path = vim.fn.input({ prompt = "path: ", default = "./src/" })
    local pathParsed = "eslint_d " .. path

    vim.fn.jobstart(pathParsed, {
        stdout_buffered = true,
        on_stdout = function(_, output)
            on_out(output)
        end,
        on_stderr = function(err)
            print(err)
        end,
    })
end, {})
