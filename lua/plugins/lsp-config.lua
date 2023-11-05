return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		},
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = "VeryLazy",
	config = function()
		---
		-- LSP Support
		---
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local lsp_config = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local map = vim.keymap

		---
		-- Global configuration
		---
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

		-- Diagnostics
		map.set("n", "gl", vim.diagnostic.open_float)
		map.set("n", "[d", vim.diagnostic.goto_prev)
		map.set("n", "]d", vim.diagnostic.goto_next)

		-- on attach.
		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr }
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
				-- eslint
				if client.name == "eslint" then
					vim.cmd(":EslintFixAll")
					return
				end

				-- default format command
				vim.lsp.buf.format({ async = true })
			end, opts)

			--eslint autoFix on save
			-- if client.name == "eslint" then
			-- 	vim.api.nvim_create_autocmd("BufWritePre", {
			-- 		buffer = bufnr,
			-- 		command = "EslintFixAll",
			-- 	})
			-- end

			--svelte refresh lsp
			if client.name == "svelte" then
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						if client.name == "svelte" then
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
						end
					end,
				})
			end
		end

		---
		-- Serve configuration
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
				"eslint",
				"stylelint_lsp",
				"jsonls",
			},
		})

		---
		-- Inizializa servers
		---

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- tsserver
		lsp_config.tsserver.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- html
		lsp_config.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- cssls
		lsp_config.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- json
		lsp_config.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- svelte
		lsp_config.svelte.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- eslint
		lsp_config.eslint.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- stylelint
		lsp_config.stylelint_lsp.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "scss", "css" },
			settings = {
				stylelintplus = {
					autoFixOnFormat = true,
					-- autoFixOnSave = true,
				},
			},
		})

		-- Emmet
		lsp_config.emmet_language_server.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "php", "twig", "scss" },
		})

		-- Lua Remove undefined global vim warning.
		lsp_config.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			},
		})
	end,
}
