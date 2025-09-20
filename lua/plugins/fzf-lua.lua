return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")
        local keymap = vim.keymap
        local R = require("custom.replace_in_quickfix")

        -- Glob: <text> -- *.js

        local send_to_qf = function(selected, opts)
            R.update_current_search(opts.last_query)
            require("fzf-lua.actions").file_sel_to_qf(selected, opts)
        end

        fzf.setup({
            winopts = {
                split = "bo new",
                preview = {
                    layout = "flex",
                    default = "builtin",
                    winopts = {
                        split = "vert new",
                    },
                },
            },
            defaults = {
                color_icons = false,
                formatter = "path.filename_first",
            },
            actions = {
                files = {
                    ["enter"] = FzfLua.actions.file_edit_or_qf,
                    ["ctrl-s"] = FzfLua.actions.file_split,
                    ["ctrl-v"] = FzfLua.actions.file_vsplit,
                    ["ctrl-t"] = FzfLua.actions.file_tabedit,
                    ["ctrl-o"] = send_to_qf,
                    ["alt-Q"] = FzfLua.actions.file_sel_to_ll,
                    ["alt-i"] = FzfLua.actions.toggle_ignore,
                    ["alt-h"] = FzfLua.actions.toggle_hidden,
                    ["alt-f"] = FzfLua.actions.toggle_follow,
                },
            },
        })

        -- Old files
        keymap.set("n", "<leader>o", function()
            FzfLua.oldfiles()
        end, {})

        -- files
        keymap.set("n", "<leader>ff", function()
            FzfLua.files()
        end, {})

        -- current buffer
        keymap.set("n", "<leader>fc", function()
            FzfLua.blines()
        end, {})

        -- grep string smart case
        keymap.set("n", "<leader>fg", function()
            FzfLua.live_grep({})
        end, {})

        -- grep string exact match
        keymap.set("n", "<leader>fG", function()
            FzfLua.live_grep({
                rg_opts = "--column --line-number --no-heading --color=always --fixed-strings --max-columns=4096 -e",
            })
        end, {})

        -- grep word under cursor
        keymap.set("n", "<leader>fs", function()
            FzfLua.grep_cword()
        end, {})

        -- grep WORD under cursor
        keymap.set("n", "<leader>fS", function()
            FzfLua.grep_cWORD()
        end, {})

        -- grep visual selection
        keymap.set("v", "<leader>fs", function()
            FzfLua.grep_visual()
        end, {})

        -- Find reference
        keymap.set("n", "<leader>fr", function()
            FzfLua.lsp_references()
        end, {})

        -- Find definition
        keymap.set("n", "<leader>fd", function()
            FzfLua.lsp_definitions()
        end, {})

        -- Find diagnosti in current document
        keymap.set("n", "<leader>fe", function()
            FzfLua.lsp_document_diagnostics()
        end, {})

        -- Find reference
        keymap.set("n", "<leader>fl", function()
            FzfLua.resume()
        end, {})

        -- Find in current file folder
        keymap.set("n", "<leader>fp", function()
            vim.ui.input(
                { prompt = "Enter path: ", default = vim.fn.expand("%:h"), completion = "file" },
                function(input)
                    if input ~= nil then
                        FzfLua.live_grep({ cwd = input })
                    end
                end
            )
        end, {})
    end,
}
