---@diagnostic disable: missing-fields

return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
        vim.keymap.set({ "x", "o" }, "af", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "if", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end)
        vim.keymap.set({ "x", "o" }, "as", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
        end)
    end,
}
