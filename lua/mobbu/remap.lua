local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Move 1 more lines up or down in normal and visual selection modes.
map("v", "<down>", ":m '>+1<CR>gv=gv")
map("v", "<up>", ":m '<-2<CR>gv=gv")
map("n", "<down>", ":m .+1<CR>==")
map("n", "<up>", ":m .-2<CR>==")

-- Go to start of line and jump by 5 lines up/down and add to jumplist.
-- ( add m' to insert in jumplit if needed es: 05jm' )
map("n", "<C-J>", "05j")
map("n", "<C-k>", "05k")
map("v", "<C-J>", "05j")
map("v", "<C-k>", "05k")

-- Move fast horizontally by 20 char
map("n", "<C-l>", "20l")
map("n", "<C-h>", "20h")

-- Move to nex/previous viewport
-- <C-i> use same code of <TAB> use <C-p> instead <C-i>
map("n", "<C-p>", "<C-i>")
map("n", "<tab>", "<C-w>w")
map("n", "<S-tab>", "<C-w><S-w>")

-- move split
map("n", "<Leader>j", "<C-w><S-j>")
map("n", "<Leader>k", "<C-w><S-k>")
map("n", "<Leader>l", "<C-w><S-l>")
map("n", "<Leader>h", "<C-w><S-h>")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +4<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -4<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -4<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +4<cr>", { desc = "Increase window width" })

--  Paste from register 0
map("n", "<Leader>p", '"0p')
map("n", "<Leader>P", '"0P')
map("v", "<Leader>p", '"0p')

--  Cut to register 0
map("v", "<Leader>x", '"0x')

-- Copy to clipboard
map("n", "<leader>c", [["+y]])
map("v", "<leader>c", [["+y]])

-- Paste from clipboard
map("n", "<leader>v", [["+p]])
map("v", "<leader>v", [["+p]])

-- 1) set active occurrence under the cursor.
-- 2) replace occurence inside selection in one step.
map("n", "<leader>*", [[:let @/="<C-r><C-w>"<CR>]], { silent = false })
map("v", "<leader>r", ":s///g<left><left>", { silent = false })

-------------

-- Replace current word under cursor, use n to go next occurrence and . to replace.
map("n", "<leader>s", "*``cgn")
--
-- Replace current selection under cursor, use n to go next occurrence and . to replace.
map("v", "<leader>s", [[y<cmd>let @/=escape(@", '/')<cr>"_cgn]])

-- replace curent accurrence and fo to next.
map("n", "<C-n>", "n.")

-- more ergonomic serach ingnore case.
map("n", "`", [[/\c<Left><Left>]], { silent = false })
map("n", "~", [[?\c<Left><Left>]], { silent = false })

-- fast replace on whole file.
map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { silent = false })

-- Jump to the previous buffer
map("n", "<C-b>", "<C-^>")

-- :q
map("n", "<Leader>q", ":q<CR>")

-- :w
map("n", "<Leader>w", ":w<CR>")

-- :qa
map("n", "<Leader>Q", ":qa!<CR>")

-- Center horizontally
map("n", "<Leader>z", "zszH")

-- Select all document
map("n", "<Leader>a", "ggVG")

-- After treesitter context selection
-- If needed select inner surround.
map("v", "`", "<Left>o<Right>o")
map("v", "~", "<Right>o<Left>o")

--Refresh buffer
map("n", "<leader>r", ":e!<CR>")

-- Format with linter for filetype.
map("n", "<leader>=", ":FixWithLinter<CR>", { noremap = true, silent = true })

-- Run stylelijnt --fix
-- map("n", "<leader>=s", "mF:%!stylelint --fix --stdin --stdin-filename <CR>`F", { noremap = true, silent = true })
-- map("n", "<leader>=S", ":! npx stylelint % --fix <CR><CR>", { noremap = true, silent = true })

-- Run prettier
-- map("n", "<leader>=p", ":! npx prettier % --write --cache<CR><CR>", { noremap = true, silent = true })

-- Run eslint --fix
-- map("n", "<leader>=e", "mF:%!eslint_d --stdin --fix-to-stdout<CR>`F", { noremap = true, silent = true })
-- map("n", "<leader>=E", ":! npx eslint % --fix<CR><CR>", { noremap = true, silent = true })

-- Terminal
map("t", "<Esc>", [[ <C-\><C-n> ]], {})

-- Fuck TNF
map("n", "!", "0f;i!important<C-ESC>g_")
map("v", "!", ":s/;/!important;/g<CR>")
