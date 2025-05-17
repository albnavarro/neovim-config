local M = {}

local active = false
local aborted = false
local current_job_id = 0

function M.set_active(value)
    active = value
end

function M.get_active()
    return active
end

function M.set_current_job(id)
    current_job_id = id
end

function M.get_current_job()
    return current_job_id
end

function M.set_aborted(value)
    aborted = value
end

function M.get_aborted()
    return aborted
end

return M
