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
            ["svelte"] = { "eslint_d", "codespell" },
            ["text"] = { "codespell" },
            ["markdown"] = { "codespell" },
        }

        -- local stylelint = require("lint").linters.stylelint
        -- stylelint.stream = "both"

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })

        -- Flat config eslint_d v 13.x
        -- vim.api.nvim_create_user_command("CheckFlatConfig", function()
        --     local root = vim.uv.cwd()
        --
        --     if
        --         vim.fn.filereadable(root .. "/eslint.config.js") == 1
        --         or vim.fn.filereadable(root .. "/eslint.config.mjs") == 1
        --         or vim.fn.filereadable(root .. "/eslint.config.cjs") == 1
        --         or vim.fn.filereadable(root .. "/eslint.config.ts") == 1
        --         or vim.fn.filereadable(root .. "/eslint.config.mts") == 1
        --         or vim.fn.filereadable(root .. "/eslint.config.cts") == 1
        --     then
        --         vim.cmd(":!ESLINT_USE_FLAT_CONFIG=true eslint_d restart")
        --         -- vim.cmd(":e!")
        --         vim.cmd.e()
        --     else
        --         vim.cmd(":!ESLINT_USE_FLAT_CONFIG= eslint_d restart")
        --         -- vim.cmd(":e!")
        --         vim.cmd.e()
        --     end
        -- end, {})
    end,
}
