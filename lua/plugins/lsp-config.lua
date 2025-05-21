return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    event = "VeryLazy",
    config = function()
        ---
        -- load dependencies
        ---
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local map = vim.keymap

        ---
        -- Endsure install
        ---

        mason.setup()
        mason_lspconfig.setup({
            automatic_enable = false,
            ensure_installed = {
                -- "ts_ls", -- Lsp config use ts_ls not mason
                "vtsls",
                "html",
                "cssls",
                "emmet_language_server",
                "lua_ls",
                "svelte",
                "vue_ls",
                -- "eslint",
                -- "stylelint_lsp",
                "jsonls",
            },
        })

        ---
        -- Serve configuration
        ---

        -- vim.lsp.enable("ts_ls")
        -- vim.lsp.enable("stylelint_lsp")
        -- vim.lsp.enable("eslint")
        vim.lsp.enable("vtsls")
        vim.lsp.enable("html")
        vim.lsp.enable("cssls")
        vim.lsp.enable("jsonls")
        vim.lsp.enable("svelte")
        vim.lsp.enable("emmet_language_server")
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("vue_ls")

        -- Global configuration
        vim.diagnostic.config({
            severity_sort = true,
            virtual_text = false,
            virtual_lines = false,
            signs = true,
            update_in_insert = false,
            underline = true,
            float = { border = "rounded" },
        })

        local command = vim.api.nvim_create_user_command

        command("LspWorkspaceAdd", function()
            vim.lsp.buf.add_workspace_folder()
        end, { desc = "Add folder to workspace" })

        command("LspWorkspaceList", function()
            vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = "List workspace folders" })

        command("LspWorkspaceRemove", function()
            vim.lsp.buf.remove_workspace_folder()
        end, { desc = "Remove folder from workspace" })

        command("InlineHintToggle", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle inline Hint" })

        -- Diagnostics
        -- in 0.10 native keybind is <C-W>d
        map.set("n", "gl", vim.diagnostic.open_float)

        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1 })
        end)

        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1 })
        end)

        ---
        -- LSP attach
        ---
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- LSP actions
                local opts = { buffer = ev.buf }

                local hover = vim.lsp.buf.hover
                ---@diagnostic disable-next-line: duplicate-set-field
                vim.lsp.buf.hover = function()
                    ---@diagnostic disable-next-line: redundant-parameter
                    return hover({
                        border = "rounded",
                        max_height = math.floor(vim.o.lines * 0.5),
                        max_width = math.floor(vim.o.columns * 0.4),
                    })
                end

                -- <C-s> is neovim default
                local signature_help = vim.lsp.buf.signature_help
                ---@diagnostic disable-next-line: duplicate-set-field
                vim.lsp.buf.signature_help = function()
                    ---@diagnostic disable-next-line: redundant-parameter
                    return signature_help({
                        border = "rounded",
                        max_height = math.floor(vim.o.lines * 0.5),
                        max_width = math.floor(vim.o.columns * 0.4),
                    })
                end

                map.set("n", "K", vim.lsp.buf.hover, opts)
                map.set("n", "gd", vim.lsp.buf.definition, opts)
                map.set("n", "gD", vim.lsp.buf.declaration, opts)
                map.set("n", "gi", vim.lsp.buf.implementation, opts)
                map.set("n", "go", vim.lsp.buf.type_definition, opts)
                map.set("n", "gr", vim.lsp.buf.references, opts)
                map.set("n", "gs", vim.lsp.buf.signature_help, opts)
                map.set("n", "<F2>", vim.lsp.buf.rename, opts)
                map.set("n", "<F4>", vim.lsp.buf.code_action, opts)
                map.set("n", "<F3>", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)

                local function client_supports_method(client, method, bufnr)
                    return client:supports_method(method, bufnr)
                end

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(ev.data.client_id)

                if
                    client
                    and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, ev.buf)
                then
                    local highlight_augroup = vim.api.nvim_create_augroup("mob-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = ev.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = ev.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("mob-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "mob-lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end
            end,
        })
    end,
}
