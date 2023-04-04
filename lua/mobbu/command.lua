-- Run Stylelint from node modules
vim.api.nvim_create_user_command("StylelintFix", ":! npx stylelint % --fix", {})

-- set conceallevel=0
vim.api.nvim_create_user_command("ConcealLevelZero", ":set conceallevel=0", {})

-- set conceallevel=0
vim.api.nvim_create_user_command(
	"RetabFour",
	":set ts=2 sts=2 noet <bar> :retab! <bar> :set ts=4 sts=4 et <bar> :retab",
	{}
)

-- Switch to html syntax
vim.api.nvim_create_user_command("SyntaxHtml", ":set filetype=html syntax=html", {})
