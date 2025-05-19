local M = {}

local active = false
local aborted = false
local current_process = nil

-- Reset global state bofore job run
function M.reset_state_before()
    active = true
    aborted = false
end

-- Reset global state after job end
function M.reset_state_after()
    active = false
    aborted = false
end

-- Getter
function M.get_active()
    return active
end

function M.get_aborted()
    return aborted
end

-- Job
function M.set_current_process(process)
    current_process = process
end

function M.kill()
    if not active or current_process == nil then
        return
    end

    aborted = true
    current_process:kill()
    current_process = nil
end

return M
