return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
        require("lint").linters_by_ft = {
            ["javascript"] = { "eslint_d", "codespell" },
            ["typescript"] = { "eslint_d", "codespell" },
            ["html"] = { "codespell" },
            ["scss"] = { "codespell", "stylelint" },
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

        vim.api.nvim_create_user_command("EnableFlatConfig", function()
            vim.cmd(":!ESLINT_USE_FLAT_CONFIG=true eslint_d restart")
            vim.cmd(":write")
        end, {})

        vim.api.nvim_create_user_command("DisableFlatConfig", function()
            vim.cmd(":!ESLINT_USE_FLAT_CONFIG= eslint_d restart")
            vim.cmd(":write")
        end, {})
    end,
}
