return {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
        local neoscroll = require("neoscroll")

        neoscroll.setup({
            mappings = { "<C-u>", "<C-d>", "<C-e>", "<C-y>" },

            -- dispatch win/cursror moved only at the end to improve
            -- prformance on various plugin
            -- es: indent blankline redraw only one time after scroll.
            pre_hook = function()
                vim.opt.eventignore:append({
                    "WinScrolled",
                    "CursorMoved",
                })
            end,
            post_hook = function()
                vim.opt.eventignore:remove({
                    "WinScrolled",
                    "CursorMoved",
                })
            end,
        })

        local keymap = {
            ["<C-u>"] = function()
                neoscroll.ctrl_u({ duration = 250 })
            end,
            ["<C-d>"] = function()
                neoscroll.ctrl_d({ duration = 250 })
            end,
            ["<C-y>"] = function()
                neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
            end,
            ["<C-e>"] = function()
                neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
            end,
        }

        local modes = { "n", "v", "x" }
        for key, func in pairs(keymap) do
            vim.keymap.set(modes, key, func)
        end
    end,
}
