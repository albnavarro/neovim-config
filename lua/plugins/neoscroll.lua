return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	config = function()
		require("neoscroll").setup({
			mappings = { "<C-u>", "<C-d>", "<C-e>", "<C-y>" },

			-- dispatch win/cursror moved only at the end to improve
			-- prformance on various plugin
			-- es: indent blankline redraw only one time after scroll.
			pre_hook = function()
				vim.opt.eventignore:append({
					"WinScrolled",
					"CursorMoved",
				})
			end,
			post_hook = function()
				vim.opt.eventignore:remove({
					"WinScrolled",
					"CursorMoved",
				})
			end,
		})

		local t = {}
		t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
		t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
		t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
		t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
		require("neoscroll.config").set_mappings(t)
	end,
}
