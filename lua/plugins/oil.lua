return {
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    keys = {
        { "<leader>to" },
    },
    config = function()
        require("oil").setup({
            default_file_explorer = false,
            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = 80,
                max_height = 30,
                border = "rounded",
            },
            keymaps = {
                ["`"] = [[/\c<Left><Left>]],
                ["~"] = [[?\c<Left><Left>]],
            },
        })

        -- vim.keymap.set("n", "<Leader>to", ":Oil --float<CR>")
        vim.keymap.set("n", "<Leader>to", ":Oil<CR>")
    end,
}
