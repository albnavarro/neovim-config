return {
	"numToStr/Comment.nvim",
	keys = { "g", { "g", mode = "v" } },
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})

		--
		-- Pug comment.
		require("Comment.ft").set("pug", { "//-%s" })
	end,
}
