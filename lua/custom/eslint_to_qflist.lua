-- https://neovim.io/doc/user/lua.html#vim.iter

local tree_api = require("nvim-tree.api")
local S = require("utils/spinner")
local is_running = false
local current_job_id = 0
local force_stop = false

local on_stdout_callback = function(data)
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

    if #entries == 0 or force_stop then
        vim.schedule(function()
            vim.notify(force_stop and "Eslint stop" or "no error found")
        end)

        is_running = false
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
    is_running = false
end

-- Start new job
vim.api.nvim_create_user_command("EslintStart", function()
    if is_running then
        return
    end

    local path = ""
    vim.ui.input({ prompt = "Enter path: ", default = "./src/js", completion = "file" }, function(input)
        if input ~= nil then
            path = input
        end
    end)

    -- check if directory is valid
    if vim.fn.isdirectory(path) == 0 then
        is_running = false

        -- schedule notify to not append multiple notify
        vim.schedule(function()
            vim.notify("path: " .. path .. " is not valid")
        end)
        return
    end

    is_running = true
    force_stop = false
    local path_parsed = "npx eslint " .. path .. " --f json"

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        S.start("eslint parsing: " .. path)
    end)

    current_job_id = vim.fn.jobstart(path_parsed, {
        stdout_buffered = true,
        on_stdout = function(_, output)
            S.stop()
            on_stdout_callback(output)
        end,
    })
end, {})

-- Stop current job
vim.api.nvim_create_user_command("EslintStop", function()
    if not is_running then
        return
    end

    force_stop = true
    vim.fn.jobstop(current_job_id)
end, {})
