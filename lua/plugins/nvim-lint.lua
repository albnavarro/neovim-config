return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		require("lint").linters_by_ft = {
			["javascript"] = { "codespell" },
			["typescript"] = { "codespell" },
			["html"] = { "codespell" },
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
