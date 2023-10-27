return {
	"ronisbr/nano-theme.nvim",
	init = function()
		vim.o.background = "light" -- or "dark".
		vim.cmd.colorscheme("nano-theme")
	end,
}
