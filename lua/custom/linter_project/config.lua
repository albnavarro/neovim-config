local ESLINT_ACTION = require("custom/linter_project/eslint")
local TSC_ACTION = require("custom/linter_project/tsc")
local STYLELINT_ACTION = require("custom/linter_project/stylelint")
local DEEP_CRUISE_ACTION = require("custom/linter_project/deep_cruise")

local M = {}

M.kill_key = "kill current command"

--- @type LinterProjectConfig
M.config = {
    {
        key = "Eslint",
        options = {
            path = "./src/js",
            command = "eslint",
            error_code = { 2 },
            fatal_string = {},
            job_options = function(command, path)
                return { command, "--exit-on-fatal-error", "--f", "json", path }
            end,
            output = "stdout",
            callback = function(output)
                return ESLINT_ACTION.on_stdout(output)
            end,
        },
    },
    {
        key = "TSC",
        options = {
            path = "./",
            command = "tsc",
            error_code = {},
            fatal_string = {
                "error TS5057", -- Cannot find tsconfig.json
            },
            job_options = function(command, path)
                return { command, "--noEmit", "--project", path }
            end,
            output = "stdout",
            callback = function(output)
                return TSC_ACTION.on_stdout(output)
            end,
        },
    },
    {
        key = "Stylelint",
        options = {
            path = "./src/scss",
            command = "stylelint",
            error_code = { 1, 64, 78 },
            fatal_string = {},
            job_options = function(command, path)
                return { command, "-f", "json", path }
            end,
            output = "stderr",
            callback = function(output)
                return STYLELINT_ACTION.on_stderr(output)
            end,
        },
    },
    {
        key = "DeepCruise",
        options = {
            path = "./src",
            command = "depcruise",
            fatal_string = {},
            -- error_code = { 1, 2, 3 },
            error_code = { 2, 3 },
            job_options = function(command, path)
                return { command, path }
            end,
            output = "stdout",
            callback = function(output)
                return DEEP_CRUISE_ACTION.on_stdout(output)
            end,
        },
    },
    { key = M.kill_key },
}

return M
