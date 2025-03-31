# Road to 0.11
- https://gpanders.com/blog/whats-new-in-neovim-0-11/

- Si possono eleminare le capabilities da lsp_config:

```lua
lsp_config.volar.setup({})
```

### Native:

```lua
vim.lsp.enable({ "emmet_language_server" })
```

- `root_dir` diventa `root_markers`, e deve essere eseguita per toranre un oggetto/tabella.
- la configirazione puo essere compiata in `.config/mvim/lsp/emmet_language_server.lua`

```lua
local root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
end

return {
    cmd = { "emmet-language-server", "--stdio" },
    filetypes = {
        "css",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "typescriptreact",
        "twig",
        "php",
    },
    root_markers = {
        root_dir(),
    },
    single_file_support = true,
}
```

- override: `after/lsp/emmet_language_server.lua`

```lua
return {
    filetypes = {
        "css",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "typescriptreact",
        "twig",
        "php",
        "pug",
    },
}
```
