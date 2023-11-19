return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"query",
				"html",
				"javascript",
				"typescript",
				"jsdoc",
				"css",
				"scss",
				"twig",
				"pug",
				"php",
				"json",
				"lua",
				"vimdoc",
				"vim",
				"svelte",
				"vue",
			},
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "+",
					node_incremental = "+",
					scope_incremental = false,
					node_decremental = "_",
				},
			},
		})

		require("ts_context_commentstring").setup({})
	end,
}
