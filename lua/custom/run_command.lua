local U = require("utils/tables_utils")
local treeApi = require("nvim-tree.api")
local is_running = false

local on_out = function(data)
    -- use pcall to avoid error of parsing
    local success, jsonData = pcall(vim.json.decode, vim.json.encode(data, { object = true, array = true }))
    if not success then
        return
    end

    -- get all result
    local results = {}
    for _, item in pairs(jsonData) do
        -- use pcall to avoid error of parsing
        local row_success, row = pcall(vim.json.decode, item)
        if row_success then
            for _, item2 in pairs(row) do
                table.insert(results, item2)
            end
        end
    end

    -- filter result with error counter > 0
    local raw_errors = U.filter(results, function(item)
        return item.errorCount > 0
    end)

    -- create quilist entries
    local entries = {}
    for _, row in pairs(raw_errors) do
        for _, item in pairs(row.messages) do
            table.insert(entries, {
                filename = row.filePath,
                lnum = item.line,
                col = item.column,
                text = item.message,
            })
        end
    end

    -- vim.print(vim.inspect(entries))

    -- Create quilist
    vim.fn.setqflist(entries)

    -- Close nvim-tree
    treeApi.tree.close()

    -- Open quilist
    vim.cmd.copen()
    is_running = false
end

vim.api.nvim_create_user_command("EslintRun", function()
    if is_running then
        vim.notify("eslint is already running")
        return
    end

    local path = vim.fn.input({ prompt = "path: ", default = "./src/js" })
    local pathParsed = "npx eslint " .. path .. " --f json"
    is_running = true

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
