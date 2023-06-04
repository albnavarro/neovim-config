return {
	"folke/twilight.nvim",
	keys = { "`" },
	config = function()
		vim.keymap.set("n", "`", ":Twilight<CR>", {})
	end,
}
