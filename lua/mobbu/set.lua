local O = vim.opt
local G = vim.g

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
O.pumheight = 10 -- completion height
G.netrw_banner = 0

-- Allow to move to previous line with arrow.
O.whichwrap:append({
    ["<"] = true,
    [">"] = true,
})
