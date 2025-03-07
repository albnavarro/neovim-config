return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        },
        "williamboman/mason-lspconfig.nvim",
        -- "hrsh7th/cmp-nvim-lsp",
        "saghen/blink.cmp",
    },
    event = "VeryLazy",
    config = function()
        ---
        -- load dependencies
        ---
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local lsp_config = require("lspconfig")
        local map = vim.keymap

        ---
        -- Endsure install
        ---

        mason.setup({})
        mason_lspconfig.setup({
            ensure_installed = {
                -- "ts_ls", -- Lsp config use ts_ls not mason
                "vtsls",
                "html",
                "cssls",
                "emmet_language_server",
                "lua_ls",
                "svelte",
                "volar",
                -- "graphql",
                -- "eslint",
                -- "stylelint_lsp",
                "jsonls",
            },
        })

        --
        -- completion capabilities
        --
        -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        ---
        -- Serve configuration
        ---

        -- tsserver
        -- lsp_config.ts_ls.setup({
        --     capabilities = capabilities,
        --     filetypes = { "typescript", "javascript", "vue" },
        --     init_options = {
        --         preferences = {
        --             includeInlayParameterNameHints = "all",
        --             includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        --             includeInlayFunctionParameterTypeHints = true,
        --             includeInlayVariableTypeHints = true,
        --             includeInlayPropertyDeclarationTypeHints = true,
        --             includeInlayFunctionLikeReturnTypeHints = true,
        --             includeInlayEnumMemberValueHints = true,
        --             importModuleSpecifierPreference = "non-relative",
        --         },
        --         plugins = {
        --             {
        --                 name = "@vue/typescript-plugin",
        --                 location = require("mason-registry").get_package("vue-language-server"):get_install_path()
        --                     .. "/node_modules/@vue/language-server",
        --                 languages = { "vue" },
        --             },
        --         },
        --     },
        -- })

        -- typescript

        -- local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
        -- local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

        lsp_config.vtsls.setup({
            capabilities = capabilities,
            filetypes = { "typescript", "javascript", "vue" },
            settings = {
                javascript = {
                    inlayHints = {
                        functionLikeReturnTypes = { enabled = true },
                        parameterNames = { enabled = "all" },
                        variableTypes = { enabled = true },
                    },
                },
                vtsls = {
                    autoUseWorkspaceTsdk = true,
                    experimental = {
                        -- Inlay hint truncation.
                        maxInlayHintLength = 30,
                        -- For completion performance.
                        completion = {
                            enableServerSideFuzzyMatch = true,
                        },
                    },
                    tsserver = {
                        globalPlugins = {
                            {
                                name = "@vue/typescript-plugin",
                                -- location = volar_path,
                                location = require("mason-registry")
                                    .get_package("vue-language-server")
                                    :get_install_path()
                                    .. "/node_modules/@vue/language-server",
                                languages = { "vue" },
                                configNamespace = "typescript",
                                enableForWorkspaceTypeScriptVersions = true,
                            },
                        },
                    },
                },
            },
        })

        -- html
        lsp_config.html.setup({ capabilities = capabilities })

        -- cssls
        lsp_config.cssls.setup({ capabilities = capabilities })

        -- jsonls
        lsp_config.jsonls.setup({ capabilities = capabilities })

        -- volar
        lsp_config.volar.setup({ capabilities = capabilities })

        -- graphql
        -- lsp_config.graphql.setup({
        --     capabilities = capabilities,
        --     filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        -- })

        -- svelte
        lsp_config.svelte.setup({
            capabilities = capabilities,
            on_attach = function(client)
                -- Refresh lsp when js o ts file change.
                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*.js", "*.ts" },
                    group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
                    callback = function(ctx)
                        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                    end,
                })
            end,
        })

        -- esLint
        -- lsp_config.eslint.setup({
        --     capabilities = capabilities,
        --     settings = { format = false },
        --     on_attach = function(_, bufnr)
        --         vim.keymap.set(
        --             "n",
        --             "<leader>ce",
        --             "<cmd>EslintFixAll<cr>",
        --             { desc = "Fix all ESLint errors", buffer = bufnr }
        --         )
        --     end,
        -- })

        -- stylelint
        -- lsp_config.stylelint_lsp.setup({
        --     capabilities = capabilities,
        --     filetypes = { "scss", "css" },
        --     settings = {
        --         stylelintplus = {
        --             autoFixOnFormat = true,
        --             -- autoFixOnSave = true,
        --         },
        --     },
        -- })

        -- Extend emmet_ls to twig and javascript
        lsp_config.emmet_language_server.setup({
            capabilities = capabilities,
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "pug",
                "typescriptreact",
                "twig",
                "php",
            },
        })

        -- Remove undefined global vim warning.
        lsp_config.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                },
            },
        })

        -- Global configuration
        vim.diagnostic.config({
            severity_sort = true,
            virtual_text = false,
            signs = true,
            update_in_insert = false,
            underline = true,
            float = { border = "rounded" },
        })

        if vim.fn.has("nvim-0.11") == 1 then
            local hover = vim.lsp.buf.hover
            vim.lsp.buf.hover = function()
                ---@diagnostic disable-next-line: redundant-parameter
                return hover({
                    border = "rounded",
                    max_height = math.floor(vim.o.lines * 0.5),
                    max_width = math.floor(vim.o.columns * 0.4),
                })
            end
        else
            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", max_width = 80 })
        end

        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", max_width = 80 })

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

        -- From 0.10 is in core
        -- map.set("n", "[d", vim.diagnostic.goto_prev)
        -- map.set("n", "]d", vim.diagnostic.goto_next)

        ---
        -- LSP attach
        ---
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- LSP actions
                local opts = { buffer = ev.buf }

                -- From 0.10 is in core
                -- map.set("n", "K", vim.lsp.buf.hover, opts)
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

                -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
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
