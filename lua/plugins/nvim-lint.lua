return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		require("lint").linters_by_ft = {
			["javascript"] = { "eslint_d", "codespell" },
			["typescript"] = { "eslint_d", "codespell" },
			["html"] = { "codespell" },
			-- ["scss"] = { "codespell", "stylelint" },
			["scss"] = { "codespell" },
			["json"] = { "codespell" },
			["jsonc"] = { "codespell" },
			["svelte"] = { "codespell" },
			["text"] = { "codespell" },
			["markdown"] = { "codespell" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
