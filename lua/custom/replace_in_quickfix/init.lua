local TREE_API = require("nvim-tree.api")
local M = {}

-- Smart case default value.
local case_search = "--fixed-strings"
local current_search = ""

-- Enable smart case.
vim.api.nvim_create_user_command("SmartCaseOn", function()
    case_search = "--smart-case"
end, {})

-- Disable smart case.
vim.api.nvim_create_user_command("SmartCaseOff", function()
    case_search = "--fixed-strings"
end, {})

-- Replace occurrence in quickFix.
-- Make a search without smart-case use exact match to void erro with no world match --
-- cdo %s/absd/dsba/gc | up
vim.api.nvim_create_user_command("ReplaceInQuickFix", function()
    if case_search == "--smart-case" then
        vim.notify("last grep is in smart-case, run SmartCaseOff!")
        return
    end

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

M.get_case_search = function()
    return case_search
end

return M
