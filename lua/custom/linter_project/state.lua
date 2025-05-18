local M = {}

local active = false
local aborted = false
local current_process = nil

-- Reset global state
function M.reset_state()
    M.set_active(true)
    M.set_aborted(false)
end

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

-- Job
function M.set_current_process(process)
    current_process = process
end

function M.kill_current_process()
    if current_process == nil then
        return
    end

    M.set_aborted(true)
    current_process:kill()
end

function M.clear_current_process()
    current_process = nil
end

function M.kill()
    if not M.get_active() then
        return
    end

    M.kill_current_process()
    M.clear_current_process()
end

return M
