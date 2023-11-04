return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				jsonc = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				twig = { { "prettierd", "prettier" } },
				svelte = { { "prettierd", "prettier" } },
				pug = { { "prettierd", "prettier" } },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {},
		})

		-- Toggle codeSpell.
		local useCodeSpell = false
		require("conform.formatters.codespell").condition = function()
			return useCodeSpell
		end

		vim.api.nvim_create_user_command("CodeSpellFormatOn", function()
			useCodeSpell = true
		end, {})

		vim.api.nvim_create_user_command("CodeSpellFormatOff", function()
			useCodeSpell = false
		end, {})
	end,
}
