local TREE_API = require("nvim-tree.api")
local M = {}

local current_search = ""

-- Replace occurrence in quickFix.
-- Make a search without smart-case use exact match to void erro with no world match --
-- cdo %s/absd/dsba/gc | up
vim.api.nvim_create_user_command("ReplaceInQuickFix", function()
    -- Close nvim-tree
    TREE_API.tree.close()

    local user_input_from = vim.fn.input({ prompt = "Occurrence to replace: ", default = current_search })
    local user_input_to = vim.fn.input({ prompt = "Replace with: ", default = current_search })

    -- Replace only occurrence in quickFix. ( no % used )
    return vim.cmd(":cdo s/" .. user_input_from .. "/" .. user_input_to .. "/gc | up")
end, {})

M.update_current_search = function(value)
    current_search = value
end

return M
