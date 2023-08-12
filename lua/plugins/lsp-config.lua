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
		local lsp_defaults = lsp_config.util.default_config
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		lsp_defaults.capabilities =
			vim.tbl_deep_extend("force", lsp_defaults.capabilities, cmp_nvim_lsp.default_capabilities())

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(args)
				local bufnr = args.buf
				local map = function(m, lhs, rhs)
					local opts = { buffer = bufnr }
					vim.keymap.set(m, lhs, rhs, opts)
				end

				-- LSP actions
				map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
				map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
				map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
				map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
				map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
				map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
				map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
				map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
				map({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
				map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
				map("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

				-- Diagnostics
				map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
				map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
				map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
			end,
		})

		local function lsp_settings()
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
		end

		lsp_settings()

		---
		-- Mason
		---

		mason.setup({})
		mason_lspconfig.setup({
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"emmet_ls",
				"lua_ls",
				"svelte",
				"eslint",
				"stylelint_lsp",
			},
		})

		---
		-- Inizializa servers
		---

		-- local get_servers = mason_lspconfig.get_installed_servers
		-- for _, server_name in ipairs(get_servers()) do
		-- 	lsp_config[server_name].setup({})
		-- end

		lsp_config.tsserver.setup({})
		lsp_config.html.setup({})
		lsp_config.cssls.setup({})
		lsp_config.svelte.setup({})
		lsp_config.eslint.setup({
			-- on_attach = function(args)
			-- 	local bufnr = args.buf
			-- 	vim.api.nvim_create_autocmd("BufWritePre", {
			-- 		buffer = bufnr,
			-- 		command = "EslintFixAll",
			-- 	})
			-- end,
		})
		lsp_config.stylelint_lsp.setup({
			filetypes = { "scss" },
			-- settings = {
			-- 	stylelintplus = {
			-- 		autoFixOnSave = true,
			-- 	},
			-- },
		})

		---
		-- Extend emmet_ls to twig and javascript
		---
		lsp_config.emmet_ls.setup({
			filetypes = { "html", "php", "twig", "scss" },
		})

		---
		-- Remove undefined global vim warning.
		---
		lsp_config.lua_ls.setup({
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
