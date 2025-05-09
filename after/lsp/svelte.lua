return {
    on_attach = function(client, bufnr)
        -- Refresh lsp when js o ts file change.
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
            callback = function(ctx)
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
        })

        vim.api.nvim_buf_create_user_command(bufnr, "LspMigrateToSvelte5", function()
            client:exec_cmd({
                command = "migrate_to_svelte_5",
                arguments = { vim.uri_from_bufnr(bufnr) },
            })
        end, { desc = "Migrate Component to Svelte 5 Syntax" })
    end,
}
