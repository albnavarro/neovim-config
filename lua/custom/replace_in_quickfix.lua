local treeApi = require("nvim-tree.api")

-- Main module
local M = {}

-- Smart case default value.
M.caseSearch = "--fixed-strings"
M.lastSearch = ""

-- Enable smart case.
vim.api.nvim_create_user_command("SmartCaseOn", function()
    M.caseSearch = "--smart-case"
end, {})

-- Disable smart case.
vim.api.nvim_create_user_command("SmartCaseOff", function()
    M.caseSearch = "--fixed-strings"
end, {})

-- Replace occurrence in quickFix.
-- Make a search without smart-case use exact match to void erro with no world match --
-- cdo %s/absd/dsba/gc | up
vim.api.nvim_create_user_command("ReplaceInQuickFix", function()
    if M.caseSearch == "--smart-case" then
        vim.notify("last grep is in smart-case, run SmartCaseOff!")
        return
    end

    -- Close nvim-tree
    treeApi.tree.close()

    local user_input_from = vim.fn.input({ prompt = "Occurrence to replace: ", default = M.lastSearch })
    local user_input_to = vim.fn.input("Replace with: ")

    -- Replace only occurrence in quickFix. ( no % used )
    return vim.cmd(":cdo s/" .. user_input_from .. "/" .. user_input_to .. "/gc | up")
end, {})

M.updateLastSearch = function(value)
    M.lastSearch = value
end

M.getCaseSearch = function()
    return M.caseSearch
end

return M
