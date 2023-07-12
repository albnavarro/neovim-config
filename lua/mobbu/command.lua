-- set conceallevel=0
vim.api.nvim_create_user_command(
	"RetabFour",
	":set ts=2 sts=2 noet <bar> :retab! <bar> :set ts=4 sts=4 et <bar> :retab",
	{}
)

-- Switch to html syntax
vim.api.nvim_create_user_command("SyntaxHtml", ":set filetype=html syntax=html", {})

-- Open terminal
vim.api.nvim_create_user_command("Terminal", ":botright 20sp |terminal", {})

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
	group = highlight_group,
	pattern = "*",
})
