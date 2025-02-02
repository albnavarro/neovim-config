local O = vim.opt
local G = vim.g

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
G.mapleader = " "
G.maplocalleader = " "

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
--
-- -- Decrease update time
vim.opt.updatetime = 250
--
-- -- Decrease mapped sequence wait time
vim.opt.timeoutlen = 600

O.guicursor = ""
O.relativenumber = false
O.number = true
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

-- completion height
O.pumheight = 10
G.netrw_banner = 0

-- Allow to move to previous line with arrow.
O.whichwrap:append({
    ["<"] = true,
    [">"] = true,
})
