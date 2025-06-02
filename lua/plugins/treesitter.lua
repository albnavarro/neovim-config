return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "html",
            "javascript",
            "typescript",
            "jsdoc",
            "graphql",
            "css",
            "scss",
            "twig",
            "pug",
            "php",
            "json",
            "lua",
            "svelte",
            "vue",
            "markdown",
        })

        -- local ensureInstalled = {
        --     "query",
        --     "html",
        --     "javascript",
        --     "typescript",
        --     "jsdoc",
        --     "graphql",
        --     "css",
        --     "scss",
        --     "twig",
        --     "pug",
        --     "php",
        --     "json",
        --     "lua",
        --     "svelte",
        --     "vue",
        -- }
        --
        -- local alreadyInstalled = require("nvim-treesitter.config").installed_parsers()
        -- local parsersToInstall = vim.iter(ensureInstalled)
        --     :filter(function(parser)
        --         return not vim.tbl_contains(alreadyInstalled, parser)
        --     end)
        --     :totable()
        -- require("nvim-treesitter").install(parsersToInstall)
    end,
}
