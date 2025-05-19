local ESLINT_ACTION = require("custom/linter_project/eslint")
local TSC_ACTION = require("custom/linter_project/tsc")
local STYLELINT_ACTION = require("custom/linter_project/stylelint")
local DEEP_CRUISE_ACTION = require("custom/linter_project/deep_cruise")

local M = {}

M.kill_key = "kill current command"

M.config = {
    {
        key = "Eslint",
        options = {
            path = "./src/js",
            command = "eslint",
            job_options = function(command, path)
                return { command, "--f", "json", path }
            end,
            output = "stdout",
            callback = function(output)
                ESLINT_ACTION.on_stdout(output)
            end,
        },
    },
    {
        key = "TSC",
        options = {
            path = "./",
            command = "tsc",
            job_options = function(command, path)
                return { command, "--project", path }
            end,
            output = "stdout",
            callback = function(output)
                TSC_ACTION.on_stdout(output)
            end,
        },
    },
    {
        key = "Stylelint",
        options = {
            path = "./src/scss",
            command = "stylelint",
            job_options = function(command, path)
                return { command, "-f", "json", path }
            end,
            output = "stderr",
            callback = function(output)
                STYLELINT_ACTION.on_stderr(output)
            end,
        },
    },
    {
        key = "DeepCruise",
        options = {
            path = "./src",
            command = "depcruise",
            job_options = function(command, path)
                return { command, path }
            end,
            output = "stdout",
            callback = function(output)
                DEEP_CRUISE_ACTION.on_stdout(output)
            end,
        },
    },
    { key = M.kill_key, options = nil },
}

return M
