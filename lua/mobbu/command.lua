-- Retab to four.
vim.api.nvim_create_user_command(
    "RetabFour",
    ":set ts=2 sts=2 noet <bar> :retab! <bar> :set ts=4 sts=4 et <bar> :retab",
    {}
)

-- Open terminal
vim.api.nvim_create_user_command("Terminal", ":botright 20sp |terminal", {})

-- Highlight on yank.
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
    group = highlight_group,
    pattern = "*",
})

-- Toggle Word Wrap.
vim.api.nvim_create_user_command("ToggleWordWrap", ":set wrap! linebreak! breakindent!", {})

-- npx stylelint
vim.api.nvim_create_user_command("NpxStyleLint", ":%!npx stylelint --fix --stdin --stdin-filename %<CR><CR>", {})

-- npx eslint
-- vim.api.nvim_create_user_command("NpxEslintLint", ":%!eslint_d --stdin --fix-to-stdout %<CR>", {})
vim.api.nvim_create_user_command("NpxEslintLint", ":! eslint_d --stdin --fix %", {})
