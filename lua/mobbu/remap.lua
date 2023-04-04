local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Open new buffer on right move to new buffer and execute Ex command
-- map("n", "<A-l>", "<C-w>v<bar><C-w>l<bar>:Ex<CR>", { silent = true })

-- Open new buffer on bottom move to new buffer and execute Ex command
-- map("n", "<A-k>", "<C-w>s<bar><C-w>j<bar>:Ex<CR>", { silent = true })

-- Move 1 more lines up or down in normal and visual selection modes.
map("v", "<down>", ":m '>+1<CR>gv=gv")
map("v", "<up>", ":m '<-2<CR>gv=gv")
map("n", "<down>", ":m .+1<CR>==")
map("n", "<up>", ":m .-2<CR>==")

-- Go to start of line and jump by 5 lines up/down and add to jumplist.
map("n", "<C-J>", "04jm'")
map("n", "<C-k>", "04km'")

-- Move to viewport
map("n", "<leader>1", "1<C-w><C-w>")
map("n", "<leader>2", "2<C-w><C-w>")
map("n", "<leader>3", "3<C-w><C-w>")
map("n", "<leader>4", "4<C-w><C-w>")
map("n", "<leader>5", "5<C-w><C-w>")

-- Resize viewport
map("n", "<C-right>", ":exe 'vertical resize' . (winwidth(0) * 3/2)<CR>")
map("n", "<C-left>", ":exe 'vertical resize' . (winwidth(0) * 2/3)<CR>")
map("n", "<C-down>", ":exe 'resize' . (winheight(0) * 3/2)<CR>")
map("n", "<C-up>", ":exe 'resize' . (winheight(0) * 2/3)<CR>")

-- Tab
-- map("n", "<leader>tn", ":tabnew <CR>")
-- map("n", "<leader>tc", ":tabclose <CR>")
-- map("n", "<leader>to", ":tabonly <CR>")

-- move split
map("n", "<Leader>j", "<C-w><S-j>")
map("n", "<Leader>k", "<C-w><S-k>")
map("n", "<Leader>l", "<C-w><S-l>")
map("n", "<Leader>h", "<C-w><S-h>")

-- Move up and down and center screen
-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")

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

-- fast replace word from current line to end of file with confirm.
map("n", "<leader>s", [[:.,$s/\<<C-r><C-w>\>//gc<Left><Left><Left>]], { silent = false })

-- fast replace on whole file.
map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { silent = false })

-- Shortcut :s/ from election
map("v", "<leader>s", ":s/", { silent = false })
--
-- Shortcut :normal from election
map("v", "n", ":normal<Space>^", { silent = false })

-- :q
map("n", "<Leader>q", ":q<CR>")

-- :w
map("n", "<Leader>w", ":w<CR>")

-- :qa
map("n", "<Leader>Q", ":qa!<CR>")

-- Center horizontally
map("n", "<Leader>z", "zszH")

-- Format all document
map("n", "<Leader>=", "gg=G``")

-- Select all document
map("n", "<Leader>a", "ggVG")
