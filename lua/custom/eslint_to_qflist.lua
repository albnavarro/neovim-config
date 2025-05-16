-- https://neovim.io/doc/user/lua.html#vim.iter

local treeApi = require("nvim-tree.api")
local is_running = false
local S = require("utils/spinner")

local on_out = function(data)
    -- use pcall to avoid error of parsing
    local success, jsonData = pcall(vim.json.decode, vim.json.encode(data))
    if not success then
        is_running = false
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

    if #entries == 0 then
        is_running = false
        vim.notify("no error found")
        vim.cmd.cclose()

        return
    end

    -- vim.print(vim.inspect(entries))

    -- Create quilist
    -- vim.fn.setqflist(entries)
    vim.fn.setqflist({}, "r", { title = "ESLINT", items = entries })
    vim.notify(#entries .. " error found")

    -- Close nvim-tree
    treeApi.tree.close()

    -- Open quilist
    vim.cmd.copen()
    is_running = false
end

vim.api.nvim_create_user_command("Eslint", function()
    if is_running then
        return
    end

    local path = ""
    vim.ui.input({ prompt = "Enter path: ", default = "./src/js", completion = "file" }, function(input)
        if input ~= nil then
            path = input

            -- clear input propt
            vim.cmd(":redraw")
            S.start("eslint parsing: " .. path)
        end
    end)

    local pathParsed = "npx eslint " .. path .. " --f json"
    is_running = true

    if path == "" then
        is_running = false
        vim.notify("missing path")
        return
    end

    vim.fn.jobstart(pathParsed, {
        stdout_buffered = true,
        on_stdout = function(_, output)
            S.stop()
            on_out(output)
        end,
        -- on_stderr = function() end,
    })
end, {})
