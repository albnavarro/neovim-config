local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
nvim_tree.setup({
	git = {
		enable = false,
		ignore = false,
	},
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
				-- { key = "<Tab>", action = "" },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

-- Open on start
local function open_nvim_tree()
	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- remap
vim.keymap.set("n", "<Leader>tt", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<Leader>tf", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<Leader>to", ":NvimTreeFocus<CR>")
vim.keymap.set("n", "<Leader>tc", ":NvimTreeClose<CR>")
