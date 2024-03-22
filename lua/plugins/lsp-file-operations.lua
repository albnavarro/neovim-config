return {
    "antosha417/nvim-lsp-file-operations",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
    },
    config = function()
        require("lsp-file-operations").setup({
            operations = {
                willRenameFiles = true,
                didRenameFiles = true,
                willCreateFiles = false,
                didCreateFiles = false,
                willDeleteFiles = false,
                didDeleteFiles = false,
            },
        })
    end,
}
