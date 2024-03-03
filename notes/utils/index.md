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
