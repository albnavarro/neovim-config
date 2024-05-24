return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
        require("lint").linters_by_ft = {
            -- ["javascript"] = { "eslint_d", "codespell" },
            -- ["typescript"] = { "eslint_d", "codespell" },
            ["javascript"] = { "codespell" },
            ["typescript"] = { "codespell" },
            ["html"] = { "codespell" },
            -- ["scss"] = { "codespell", "stylelint" },
            ["scss"] = { "codespell" },
            ["json"] = { "codespell" },
            ["jsonc"] = { "codespell" },
            ["svelte"] = { "codespell" },
            ["text"] = { "codespell" },
            ["markdown"] = { "codespell" },
        }

        local stylelint = require("lint").linters.stylelint
        stylelint.stream = "both"

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
