# Road to 0.11
- https://gpanders.com/blog/whats-new-in-neovim-0-11/
- vim.lsp

```lua
-- new
-- https://github.com/neovim/neovim/pull/31208
local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field

vim.lsp.buf.hover = function()
    return hover({
        border = "rounded",
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
    })
end


-- old deprecated
-- https://github.com/neovim/neovim/pull/30935
-- vim.lsp.handlers["textDocument/hover"] =
--     vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", max_width = 80 })
```


- `vim.hl` instead `vim.highlight`
```lua

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "Visual", timeout = 200 })
    end,
    group = highlight_group,
    pattern = "*",
})
```
