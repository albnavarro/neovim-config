local M = {}

local active = false
local aborted = false
local current_job_id = 0

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

-- Job aborted by user.
function M.set_current_job_id(value)
    current_job_id = value
end

function M.get_current_job_id()
    return current_job_id
end

return M
