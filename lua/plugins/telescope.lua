return {
    "nvim-telescope/telescope.nvim",
    -- branch = "0.1.x",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
        "nvim-lua/plenary.nvim",
    },
    -- keys = { "<leader>f", "<leader>o" },
    config = function()
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local ivy = require("telescope.themes").get_ivy()
        local custom = require("utils/telescope_utils")
        local custom_rg = require("custom/telescope_multi_rg")
        local tables_utils = require("utils/tables_utils")

        vim.keymap.set("n", "<leader>fa", builtin.builtin, {})
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, {})
        vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
        vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set("n", "<leader>fl", builtin.resume, {})
        vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})
        vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
        vim.keymap.set("v", "<leader>fs", custom.exact_search_visual, {})
        -- vim.keymap.set("n", "<leader>fm", custom.live_grep_in_glob, {})
        vim.api.nvim_set_keymap("n", "<leader>fp", "", {
            expr = true,
            callback = custom.find_in_specific_folder,
        })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set("n", "<leader>fn", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[F]earch [N]eovim files" })

        -- Custom live grep with shortcut
        vim.keymap.set("n", "<leader>fg", function()
            custom_rg.multi_rg(ivy)
        end, { desc = "[F]ind [N]eovim grep" })

        -- Default pickers setting
        local pickersSettings = tables_utils.map(builtin, function()
            return {
                theme = "ivy",
                disable_devicons = true,
                color_devicons = false,
            }
        end)

        -- setup
        require("telescope").setup({
            defaults = {
                path_display = {
                    "filename_first",
                },
                mappings = {
                    i = {
                        -- Open quicklis with multiple files
                        ["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        -- ["<esc>"] = actions.close,
                    },
                    n = {
                        -- Open quicklis with multiple files
                        ["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                    },
                },
            },
            pickers = pickersSettings,
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
