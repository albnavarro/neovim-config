return {
	"antosha417/nvim-lsp-file-operations",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-tree.lua",
	},
	config = function()
		require("lsp-file-operations").setup()
	end,
}
