local STATE = require("custom/linter_project/state")

-- Stop current job
vim.api.nvim_create_user_command("StopParse", function()
    STATE.kill()
end, {})
