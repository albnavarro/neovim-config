# Road to 0.11
- In case hover problem override default:


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


