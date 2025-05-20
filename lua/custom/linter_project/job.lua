local SPINNER = require("utils/spinner")
local UTILS = require("custom/linter_project/utils")
local NVIM_UTILS = require("utils/nvim_utils")

-- shared state
local STATE = require("custom/linter_project/state")

local M = {}

--- @param options LinterProjectConfigOptions
function M.start(options)
    options = options or {}

    if STATE.get_active() then
        return
    end

    local path = NVIM_UTILS.use_vim_input_path({ path = options.path })

    -- check if directory is valid
    local directory_is_valid = UTILS.is_directory_with_warning(path)
    if not directory_is_valid then
        return
    end

    local is_exutable, command = NVIM_UTILS.get_bin_with_warning(options.command)
    if not is_exutable then
        return
    end

    STATE.reset_state_before()

    -- schedule notify to not append multiple notify
    vim.schedule(function()
        SPINNER.start(options.command .. " parsing: " .. path)
    end)

    vim.schedule(function()
        local on_exit = function(result)
            -- get fatal error by code
            local error_code = vim.tbl_contains(options.error_code, result.code)

            -- get fatal error by stdout/stderr content
            local stdall = (result.stdout or "") .. (result.stderr or "")
            local fatal_string = vim.iter(options.fatal_string):any(function(item)
                -- find string with : or a space before
                return string.find(stdall, "[%s:]" .. item) ~= nil
            end)

            if error_code or fatal_string then
                SPINNER.stop()
                STATE.reset_state_after()

                vim.schedule(function()
                    vim.cmd.cclose()
                    vim.notify(vim.inspect(result))
                end)

                return
            end

            local output = options.output == "stderr" and UTILS.parse_std_err(result) or UTILS.parse_std_out(result)

            vim.schedule(function()
                SPINNER.stop()
                local entries = options.callback(output)

                UTILS.setqflist({
                    name = options.command,
                    entries = entries or {},
                })
            end)
        end

        local cmd = vim.system(options.job_options(command, path), {}, on_exit)
        STATE.set_current_process(cmd)
    end)
end

return M
