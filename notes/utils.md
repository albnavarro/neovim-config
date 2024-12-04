### Show diagnostic only on save.
```
 -- Disable diagnostic on enter buffer and insertEnter
vim.api.nvim_create_autocmd({ "BufNew", "InsertEnter" }, {
    -- or vim.api.nvim_create_autocmd({"BufNew", "TextChanged", "TextChangedI", "TextChangedP", "TextChangedT"}, {
    callback = function(args)
        vim.diagnostic.disable(args.buf)
    end,
})

-- Enable diagnostic on buffer write
vim.api.nvim_create_autocmd({ "BufWrite" }, {
    callback = function(args)
        vim.diagnostic.enable(args.buf)
    end,
})
```
