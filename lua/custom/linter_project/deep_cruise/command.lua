local SPINNER = require("utils/spinner")
local ACTION = require("custom/linter_project/deep_cruise/action")
local COMMON_ACTION = require("custom/linter_project/action")
local NVIM_UTILS = require("utils/nvim_utils")

-- shared state
local STATE = require("custom/linter_project/state")

-- Start new job
vim.api.nvim_create_user_command("DepcruiseParse", function()
    if STATE.get_active() then
        return
    end

    local path = ""
    vim.ui.input({ prompt = "Enter path: ", default = "./src", completion = "file" }, function(input)
        if input ~= nil then
            path = input
        end
    end)

    local directory_is_valid = COMMON_ACTION.is_directory_with_warning(path)
    if not directory_is_valid then
        return
    end

    local is_exutable, command = NVIM_UTILS.is_executable_with_warning("depcruise")
    if not is_exutable then
        return
    end

    STATE.set_active(true)
    STATE.set_aborted(false)

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        SPINNER.start("depcruise parsing: " .. path)
    end)

    local id = vim.fn.jobstart(command .. " " .. path, {
        stdout_buffered = true,
        on_stdout = function(_, output)
            SPINNER.stop()
            ACTION.on_stdout(output)
        end,
    })

    STATE.set_current_job_id(id)
end, {})
