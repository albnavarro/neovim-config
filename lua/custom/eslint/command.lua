local SPINNER = require("utils/spinner")
local ACTION = require("custom/eslint/action")

-- shared state
local STATE = require("custom/eslint/state")

-- private
local current_job_id = 0

-- Start new job
vim.api.nvim_create_user_command("EslintStart", function()
    if STATE.get_active() then
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
        STATE.set_active(false)

        -- schedule notify to not append multiple notify
        vim.schedule(function()
            vim.notify("path: " .. path .. " is not valid")
        end)
        return
    end

    STATE.set_active(true)
    STATE.set_aborted(false)
    local path_parsed = "npx eslint " .. path .. " --f json"

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        SPINNER.start("eslint parsing: " .. path)
    end)

    current_job_id = vim.fn.jobstart(path_parsed, {
        stdout_buffered = true,
        on_stdout = function(_, output)
            SPINNER.stop()
            ACTION.on_stdout(output)
        end,
    })
end, {})

-- Stop current job
vim.api.nvim_create_user_command("EslintStop", function()
    -- if not is_running then
    if not STATE.get_active() then
        return
    end

    STATE.set_aborted(true)
    vim.fn.jobstop(current_job_id)
end, {})
