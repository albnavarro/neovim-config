return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		"nvim-lua/plenary.nvim",
	},
	keys = { "<leader>f", "<leader>o" },
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local custom = require("utils/telescope_custom")
		local multi_rg = require("utils/telescope_multi_rg")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
		vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>fl", builtin.resume, {})
		vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
		vim.keymap.set("v", "<leader>fs", custom.exact_search_visual, {})
		vim.keymap.set("n", "<leader>fm", custom.live_grep_in_glob, {})
		vim.keymap.set("n", "<leader>fM", multi_rg, {})
		vim.api.nvim_set_keymap("n", "<leader>fd", "", {
			expr = true,
			callback = custom.find_in_specific_folder,
		})

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						-- Open quicklis with multiple files
						["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
						-- ["<esc>"] = actions.close,
					},
					n = {
						-- Open quicklis with multiple files
						["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				oldfiles = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				live_grep = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				grep_string = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				help_tags = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				lsp_references = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				diagnostic = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				buffers = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				current_buffer_fuzzy_find = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
				resume = {
					theme = "ivy",
					disable_devicons = true,
					color_devicons = false,
				},
			},
			extensions = {
				fzf = {},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")
	end,
}
