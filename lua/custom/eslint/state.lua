local M = {}

local active = false
local aborted = false

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

return M
