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
		local utils = require("utils/get_selection")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

		-- Search for exact word in normal mode
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})

		-- Search for exact word in visual mode
		vim.keymap.set("v", "<leader>fs", function()
			require("telescope.builtin").live_grep({
				default_text = utils.getVisualSelection(),
				only_sort_text = true,
				additional_args = function()
					return { "--pcre2" }
				end,
			})
		end)

		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
		vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>fl", builtin.resume, {})
		vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})

		-- Live grep inside folder. ( copy path from nvim-tree "Y" )
		-- vim.keymap.set("n", "<leader>fd", ":Telescope live_grep search_dirs=", { silent = false })

		-- Live grep inside folder.
		-- Open a file in specific folder and automplete dir without filename.
		vim.api.nvim_set_keymap("n", "<leader>fd", "", {
			expr = true,
			callback = function()
				local fullPath = vim.api.nvim_buf_get_name(0)
				local fullPathLessName = fullPath:match("(.+)%/.+$")
				return ":Telescope live_grep search_dirs=" .. fullPathLessName
			end,
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
