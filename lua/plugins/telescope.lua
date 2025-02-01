return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
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
        local utils = require("custom/telescope_utils")
        local custom_rg = require("custom/telescope_multi_rg")
        local U = require("utils/tables_utils")
        local R = require("custom.replace_in_quickfix")

        vim.keymap.set("n", "<leader>fa", builtin.builtin, {})
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        -- vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, {})
        vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set("n", "<leader>fl", builtin.resume, {})
        vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})
        vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
        vim.keymap.set("v", "<leader>fs", utils.exact_search_visual, {})
        vim.keymap.set("n", "<leader>fm", utils.live_grep_in_glob, {})

        -- Search from current folder where current buffer is
        vim.api.nvim_set_keymap("n", "<leader>fp", "", {
            expr = true,
            callback = utils.find_in_specific_folder,
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
        local pickersSettings = U.map(builtin, function()
            return {
                theme = "ivy",
                disable_devicons = true,
                color_devicons = false,
            }
        end)

        -- Update pattern to replace
        local function updateSearch(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            R.updateLastSearch(current_picker:_get_prompt())
        end

        -- Update pattern to replace and send selected to quicklist
        local function sendSelectedToQfList(prompt_bufnr)
            updateSearch(prompt_bufnr)
            actions.send_selected_to_qflist(prompt_bufnr)
            actions.open_qflist(prompt_bufnr)
        end

        -- setup
        require("telescope").setup({
            defaults = {
                path_display = {
                    "filename_first",
                },
                mappings = {
                    i = {
                        -- Open quicklis with multiple files
                        ["<C-o>"] = sendSelectedToQfList,
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<C-y>"] = actions.select_default,
                    },
                    n = {
                        -- Open quicklis with multiple files
                        ["<C-o>"] = sendSelectedToQfList,
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<C-y>"] = actions.select_default,
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
