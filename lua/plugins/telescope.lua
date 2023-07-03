return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = { "<leader>f", "<leader>o" },
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
		vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, {})
		vim.keymap.set("n", "<leader>fj", builtin.jumplist, {})
		vim.keymap.set("n", "<leader>fm", builtin.marks, {})
		vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						-- Open quicklis with multiple files
						["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
					},
					n = {
						-- Open quicklis with multiple files
						["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})
	end,
}
