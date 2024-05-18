return {
    "jay-babu/mason-null-ls.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
        ---
        -- null_ls
        ---
        local mason_null_ls = require("mason-null-ls")
        local null_ls = require("null-ls")

        mason_null_ls.setup({
            ensure_installed = {
                "prettierd",
                "stylua",
                "eslint_d",
                "stylelint",
            },
        })

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_action = null_ls.builtins.code_actions

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        local lsp_formatting = function(bufnr)
            vim.lsp.buf.format({
                filter = function(client)
                    -- apply whatever logic you want (in this example, we'll only use null-ls)
                    return client.name == "null-ls"
                end,
                bufnr = bufnr,
            })
        end

        null_ls.setup({
            sources = {
                -- formatting.stylelint,
                -- formatting.eslint_d,
                formatting.prettierd.with({ extra_filetypes = { "pug", "twig" } }),
                formatting.stylua,
                formatting.trim_whitespace,
                diagnostics.eslint_d,
                diagnostics.stylelint,
                code_action.eslint_d,
                code_action.gitsigns,
            },
            -- you can reuse a shared lspconfig on_attach callback here
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            lsp_formatting(bufnr)
                        end,
                    })
                end
            end,

            -- vim.api.nvim_create_user_command("FormatCommandExample", function(args)
            -- 	lsp_formatting(args.buf)
            -- end, {}),
        })
    end,
}
