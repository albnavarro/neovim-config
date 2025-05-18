local SPINNER = require("utils/spinner")
local ACTION = require("custom/linter_project/eslint/action")
local COMMON_ACTION = require("custom/linter_project/action")
local NVIM_UTILS = require("utils/nvim_utils")

-- shared state
local STATE = require("custom/linter_project/state")

-- Start new job
vim.api.nvim_create_user_command("EslintParse", function()
    if STATE.get_active() then
        return
    end

    local path = NVIM_UTILS.use_vim_input_file("./src/js")

    -- check if directory is valid
    local directory_is_valid = COMMON_ACTION.is_directory_with_warning(path)
    if not directory_is_valid then
        return
    end

    local is_exutable, command = NVIM_UTILS.get_bin_with_warning("eslint")
    if not is_exutable then
        return
    end

    STATE.reset_state_before()

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        SPINNER.start("eslint parsing: " .. path)
    end)

    vim.schedule(function()
        local on_exit = function(result)
            local stdout = result.stdout and vim.split(result.stdout, "\n") or {}

            vim.schedule(function()
                ACTION.on_stdout(stdout)
                SPINNER.stop()
            end)
        end

        local cmd = vim.system({ command, path, "--f", "json" }, { text = false }, on_exit)
        STATE.set_current_process(cmd)
    end)
end, {})
