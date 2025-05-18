local STATE = require("custom/linter_project/state")

-- Stop current job
vim.api.nvim_create_user_command("StopParse", function()
    -- if not is_running then
    if not STATE.get_active() then
        return
    end

    STATE.set_aborted(true)

    -- vim.system
    STATE.kill_current_process()

    -- vim.fn.jobstart
    -- vim.fn.jobstop(STATE.get_current_job_id())
end, {})
