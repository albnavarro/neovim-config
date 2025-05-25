local O = vim.opt_local

O.tabstop = 4
O.softtabstop = 4
O.shiftwidth = 4
O.expandtab = true
vim.bo.commentstring = "//%s"

-- treesitter
vim.treesitter.start()
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
