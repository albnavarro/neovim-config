local SPINNER = require("utils/spinner")

-- shared state
local STATE = require("custom/linter_project/state")
local ACTION = require("custom/linter_project/tsc/action")

-- Start new job
vim.api.nvim_create_user_command("TSCParse", function()
    if STATE.get_active() then
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
