return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- manson
		"williamboman/mason.nvim",
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

				-- Format ( inactive use only mason )
				-- local buf_command = vim.api.nvim_buf_create_user_command
				-- buf_command(bufnr, "LspFormat", function()
				-- 	vim.lsp.buf.format()
				-- end, { desc = "Format buffer with language server" })

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

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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

		---
		-- Extend emmet_ls to twig and javascript
		---
		lsp_config.emmet_ls.setup({
			filetypes = { "html", "php", "twig" },
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
