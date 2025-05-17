local SPINNER = require("utils/spinner")
local COMMON_ACTION = require("custom/linter_project/action")
local NVIM_UTILS = require("utils/nvim_utils")

-- shared state
local STATE = require("custom/linter_project/state")
local ACTION = require("custom/linter_project/tsc/action")

-- Start new job
vim.api.nvim_create_user_command("TSCParse", function()
    if STATE.get_active() then
        return
    end

    local tsc_path = COMMON_ACTION.find_tsc_bin()

    if not NVIM_UTILS.is_executable(tsc_path) then
        vim.schedule(function()
            vim.notify(
                "tsc was not available or found in your node_modules or $PATH. Please run install and try again."
            )
        end)

        return
    end

    STATE.set_active(true)
    STATE.set_aborted(false)

    local command = "npx tsc"

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        SPINNER.start("TSC parsing")
    end)

    local id = vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = function(_, output)
            SPINNER.stop()
            ACTION.on_stdout(output)
        end,
    })

    STATE.set_current_job_id(id)
end, {})
