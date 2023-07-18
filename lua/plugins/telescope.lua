return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		"nvim-lua/plenary.nvim",
	},
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
		vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})

		-- Live grep inside folder.
		vim.keymap.set("n", "<leader>fd", ":Telescope live_grep search_dirs=", { silent = false })

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
			extensions = {
				fzf = {},
			},
		})

		require("telescope").load_extension("fzf")
	end,
}
