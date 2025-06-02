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
    end,
}
