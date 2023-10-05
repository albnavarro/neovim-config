local O = vim.opt
local G = vim.g

O.guicursor = ""
O.nu = true
O.relativenumber = false
O.tabstop = 4
O.softtabstop = 4
O.shiftwidth = 4
O.expandtab = true
O.mouse:append("a")
O.autoindent = true
O.wrap = false
O.swapfile = false
O.backup = false
O.undodir = os.getenv("HOME") .. "/.vim/undodir"
O.undofile = true
O.hlsearch = false
O.incsearch = true
O.termguicolors = true
O.scrolloff = 4
O.signcolumn = "yes"
O.colorcolumn = "80"
O.cursorline = true
G.netrw_banner = 0

-- Allow to move to previous line with arrow.
O.whichwrap:append({
	["<"] = true,
	[">"] = true,
})
