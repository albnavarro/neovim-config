local SPINNER = require("utils/spinner")
local COMMON_ACTION = require("custom/linter_project/action")
local ACTION = require("custom/linter_project/eslint/action")
local NVIM_UTILS = require("utils/nvim_utils")

-- shared state
local STATE = require("custom/linter_project/state")

-- Start new job
vim.api.nvim_create_user_command("EslintParse", function()
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

    local command = COMMON_ACTION.find_bin_in_node_modules("eslint")

    if not NVIM_UTILS.is_executable(command) then
        vim.schedule(function()
            vim.notify(
                "eslint was not available or found in your node_modules or $PATH. Please run install and try again."
            )
        end)

        return
    end

    STATE.set_active(true)
    STATE.set_aborted(false)

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        SPINNER.start("eslint parsing: " .. path)
    end)

    local id = vim.fn.jobstart(command .. " " .. path .. " --f json", {
        stdout_buffered = true,
        on_stdout = function(_, output)
            SPINNER.stop()
            ACTION.on_stdout(output)
        end,
    })

    STATE.set_current_job_id(id)
end, {})
