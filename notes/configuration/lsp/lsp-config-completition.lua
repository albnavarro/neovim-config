return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        },
        "williamboman/mason-lspconfig.nvim",
        -- "hrsh7th/cmp-nvim-lsp",
    },
    event = "VeryLazy",
    config = function()
        ---
        -- load dependencies
        ---
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local lsp_config = require("lspconfig")
        -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local map = vim.keymap

        ---
        -- Endsure install
        ---

        mason.setup({})
        mason_lspconfig.setup({
            ensure_installed = {
                "tsserver",
                "html",
                "cssls",
                "emmet_language_server",
                "lua_ls",
                "svelte",
                -- "eslint",
                -- "stylelint_lsp",
                "jsonls",
            },
        })

        --
        -- cmp capabilities
        --
        -- local capabilities = cmp_nvim_lsp.default_capabilities()

        ---
        -- Serve configuration
        ---

        -- tsserver
        lsp_config.tsserver.setup({
            -- capabilities = capabilities,
            init_options = {
                preferences = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                    importModuleSpecifierPreference = "non-relative",
                },
            },
        })

        -- html
        -- lsp_config.html.setup({ capabilities = capabilities })
        lsp_config.html.setup({})

        -- cssls
        -- lsp_config.cssls.setup({ capabilities = capabilities })
        lsp_config.cssls.setup({})

        -- jsonls
        -- lsp_config.jsonls.setup({ capabilities = capabilities })
        lsp_config.jsonls.setup({})

        -- svelte
        lsp_config.svelte.setup({
            -- capabilities = capabilities,
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
        --     -- on_attach = function(args)
        --     -- 	local bufnr = args.buf
        --     -- 	vim.api.nvim_create_autocmd("BufWritePre", {
        --     -- 		buffer = bufnr,
        --     -- 		command = "EslintFixAll",
        --     -- 	})
        --     -- end,
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
            -- capabilities = capabilities,
            filetypes = { "html", "php", "twig", "scss", "javascript" },
        })

        -- Remove undefined global vim warning.
        lsp_config.lua_ls.setup({
            -- capabilities = capabilities,
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

        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", max_width = 80 })

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

                --- COMPLETITION test nvim 0.11
                --- https://www.reddit.com/r/neovim/comments/1d7j0c1/a_small_gist_to_use_the_new_builtin_completion/
                ---
                ---  FUZZY-FINDER on completition nvim 0.11
                ---  :set completeopt+=fuzzy
                ---  <C-n> e alla prima lettera scritta si attiva il fuzzy-finder

                local bufnr = ev.buf
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local methods = vim.lsp.protocol.Methods

                ---For replacing certain <C-x>... keymaps.
                ---@param keys string
                local function feedkeys(keys)
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
                end

                ---Is the completion menu open?
                local function pumvisible()
                    return tonumber(vim.fn.pumvisible()) ~= 0
                end

                -- Enable completion and configure keybindings.
                if client.supports_method(methods.textDocument_completion) then
                    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })

                    ---Utility for keymap creation.
                    ---@param lhs string
                    ---@param rhs string|function
                    ---@param opts string|table
                    ---@param mode? string|string[]
                    local function keymap(lhs, rhs, opts, mode)
                        opts = type(opts) == "string" and { desc = opts }
                            or vim.tbl_extend("error", opts --[[@as table]], { buffer = bufnr })
                        mode = mode or "n"
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end

                    -- Use enter to accept completions.
                    keymap("<cr>", function()
                        return pumvisible() and "<C-y>" or "<cr>"
                    end, { expr = true }, "i")

                    -- Use slash to dismiss the completion menu.
                    keymap("/", function()
                        return pumvisible() and "<C-e>" or "/"
                    end, { expr = true }, "i")

                    -- Use <C-n> to navigate to the next completion or:
                    -- - Trigger LSP completion.
                    -- - If there's no one, fallback to vanilla omnifunc.
                    keymap("<C-n>", function()
                        if pumvisible() then
                            feedkeys("<C-n>")
                        else
                            if next(vim.lsp.get_clients({ bufnr = 0 })) then
                                vim.lsp.completion.trigger()
                            else
                                if vim.bo.omnifunc == "" then
                                    feedkeys("<C-x><C-n>")
                                else
                                    feedkeys("<C-x><C-o>")
                                end
                            end
                        end
                    end, "Trigger/select next completion", "i")

                    -- Buffer completions.
                    -- funziona solo ul buffere corrente, per i tutti i buffer visibili ?
                    keymap("<C-u>", "<C-x><C-n>", { desc = "Buffer completions" }, "i")

                    -- Inside a snippet, use backspace to remove the placeholder.
                    keymap("<BS>", "<C-o>s", {}, "s")
                end
            end,
        })
    end,
}
