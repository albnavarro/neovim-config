return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("ibl").setup({
			-- indent = { highlight = { "IndentBlankLine" }, char = "│" },
			indent = { char = "|" },
			scope = { enabled = false },
		})
	end,
}
