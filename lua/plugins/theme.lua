return {
	"yorickpeterse/nvim-grey",
	name = "grey",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "light"
		vim.opt.laststatus = 3
		vim.cmd("colorscheme grey")
	end,
	opts = {},
}
