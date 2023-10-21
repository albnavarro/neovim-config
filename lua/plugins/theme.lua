return {
	"RRethy/nvim-base16",
	name = "nvim-base16",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "light"
		require("base16-colorscheme").with_config({
			telescope = false,
			cmp = false,
		})

		vim.cmd("colorscheme base16-tokyo-night-light")

		-- choice theme
		vim.api.nvim_create_user_command("TokioDark", "colorscheme base16-tokyo-night-storm", {})
		vim.api.nvim_create_user_command("TokioLight", "colorscheme base16-tokyo-night-light", {})
		vim.api.nvim_create_user_command("Metal", "colorscheme base16-black-metal-marduk", {})

		-- Disable line number
	end,
	opts = {},
}
