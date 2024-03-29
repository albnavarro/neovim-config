## Open quickfix with grep, persistent search result inside buffer.

```
:vimgrep occurrence %
:copen
```


## Find and replace from quickfix/quickList.
```
:cdo %s/absd/dsba/gc
```


## old keymap
```
-- Move fast horizontally by 20 char
map("n", "<C-l>", "20l")
map("n", "<C-h>", "20h")

-- Make U opposite to u.
map("n", "U", "<C-r>", { desc = "Redo" })

-- Clear search with <esc>.
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Word navigation in non-normal modes.
vim.keymap.set({ 'i', 'c' }, '<C-h>', '<C-Left>', { desc = 'Move word(s) backwards' })
vim.keymap.set({ 'i', 'c' }, '<C-l>', '<C-Right>', { desc = 'Move word(s) forwards' })

-- Run stylelijnt --fix
map("n", "<leader>=s", ":%!stylelint --fix --stdin --stdin-filename %<CR><CR>", { noremap = true, silent = true })

-- Run prettier
map("n", "<leader>=p", ":%!npx prettier --stdin-filepath %<CR>", { noremap = true, silent = true })

-- Run eslint --fix
map("n", "<leader>=e", ":%!eslint_d --stdin --fix-to-stdout %<CR>", { noremap = true, silent = true })

```
