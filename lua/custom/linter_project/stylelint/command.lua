local SPINNER = require("utils/spinner")
local ACTION = require("custom/linter_project/stylelint/action")
local UTILS = require("custom/linter_project/utils")
local NVIM_UTILS = require("utils/nvim_utils")

-- shared state
local STATE = require("custom/linter_project/state")

-- Start new job
vim.api.nvim_create_user_command("StylelintParse", function()
    if STATE.get_active() then
        return
    end

    local path = NVIM_UTILS.use_vim_input_file({ path = "./src/scss" })

    -- check if directory is valid
    local directory_is_valid = UTILS.is_directory_with_warning(path)
    if not directory_is_valid then
        return
    end

    local is_exutable, command = NVIM_UTILS.get_bin_with_warning("stylelint")
    if not is_exutable then
        return
    end

    STATE.reset_state_before()

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        SPINNER.start("stylelint parsing: " .. path)
    end)

    vim.schedule(function()
        local on_exit = function(result)
            local stderr = UTILS.parse_std_err(result)

            vim.schedule(function()
                ACTION.on_stderr(stderr)
                SPINNER.stop()
            end)
        end

        local cmd = vim.system({ command, "-f", "json", path }, { text = false }, on_exit)
        STATE.set_current_process(cmd)
    end)
end, {})
