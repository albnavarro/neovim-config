local M = {}

local active = false
local aborted = false
local current_job_id = 0
local current_process = nil

-- Active state.
function M.set_active(value)
    active = value
end

function M.get_active()
    return active
end

-- Job aborted by user.
function M.set_aborted(value)
    aborted = value
end

function M.get_aborted()
    return aborted
end

-- with vim.fn.jobstart()
-- Job aborted by user.
function M.set_current_job_id(value)
    current_job_id = value
end

function M.get_current_job_id()
    return current_job_id
end

-- with vim.system()
-- Job aborted by user.
function M.set_current_process(process)
    current_process = process
end

function M.kill_current_process()
    if current_process == nil then
        return
    end

    return current_process:kill()
end

function M.clear_current_process()
    current_process = nil
end

return M
