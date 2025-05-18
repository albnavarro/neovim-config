local STATE = require("custom/linter_project/state")

-- Select Command
vim.api.nvim_create_user_command("StartProjectCheck", function()
    vim.ui.select({ "Eslint", "TSC", "DeepCruise" }, {
        prompt = "Select command",
    }, function(choice)
        if choice == "Eslint" then
            vim.cmd("EslintParse")
            return
        end

        if choice == "TSC" then
            vim.cmd("TSCParse")
            return
        end

        if choice == "DeepCruise" then
            vim.cmd("DepcruiseParse")
            return
        end
    end)
end, {})

-- Stop current job
vim.api.nvim_create_user_command("StopProjectCheck", function()
    STATE.kill()
end, {})
