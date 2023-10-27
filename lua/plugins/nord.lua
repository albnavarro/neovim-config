return {
	"shaunsingh/nord.nvim",
	name = "nord",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.nord_bold = false
		vim.cmd("colorscheme nord")
	end,
	opts = {},
}
