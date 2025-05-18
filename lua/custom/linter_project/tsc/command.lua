local SPINNER = require("utils/spinner")
local ACTION = require("custom/linter_project/tsc/action")
local NVIM_UTILS = require("utils/nvim_utils")

-- shared state
local STATE = require("custom/linter_project/state")

-- Start new job
vim.api.nvim_create_user_command("TSCParse", function()
    if STATE.get_active() then
        return
    end

    local is_exutable, command = NVIM_UTILS.is_executable_with_warning("tsc")
    if not is_exutable then
        return
    end

    STATE.set_active(true)
    STATE.set_aborted(false)

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        SPINNER.start("TSC parsing")
    end)

    vim.schedule(function()
        local id = vim.fn.jobstart(command, {
            stdout_buffered = true,
            on_stdout = function(_, output)
                SPINNER.stop()
                ACTION.on_stdout(output)
            end,
        })

        STATE.set_current_job_id(id)
    end)
end, {})
