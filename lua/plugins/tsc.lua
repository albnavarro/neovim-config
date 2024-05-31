return {
    "dmmulroy/tsc.nvim",
    config = function()
        require("tsc").setup({
            bin_path = vim.fn.findfile("node_modules/.bin/tsc"),
        })
    end,
}
