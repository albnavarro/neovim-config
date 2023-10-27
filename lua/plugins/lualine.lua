return {
	"nvim-lualine/lualine.nvim",
	name = "lualine",
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	lazy = false,
	config = function()
		-- local mobbuLine = require("mobbu.colors")

		require("lualine").setup({
			options = {
				-- theme = mobbuLine,
				theme = "nano-theme",
				icons_enabled = true,
				component_separators = "",
				section_separators = "",
				"filename",
				-- path = 2,
			},
		})
	end,
}
