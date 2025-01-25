return {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    version = "v0.11.0",
    opts = {
        keymap = { preset = "default" },
        appearance = {
            nerd_font_variant = "normal",
        },
        snippets = {
            preset = "luasnip",
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = false,
                },
            },
            trigger = {
                show_on_trigger_character = true,
                show_on_accept_on_trigger_character = false,
            },
            list = {
                selection = { preselect = true, auto_insert = true },
            },
            menu = {
                auto_show = true,
                min_width = 10,
                max_height = 10,
                border = "rounded",
                winblend = vim.o.pumblend,
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                draw = {
                    columns = { { "label", "label_description", "source_name", gap = 1 }, { "kind_icon", "kind" } },
                },
            },
            documentation = {
                auto_show = false,
                treesitter_highlighting = true,
                window = {
                    min_width = 10,
                    max_width = 60,
                    max_height = 20,
                    border = "rounded",
                    winblend = vim.o.pumblend,
                    scrollbar = true,
                    direction_priority = {
                        menu_north = { "e", "w", "n", "s" },
                        menu_south = { "e", "w", "s", "n" },
                    },
                },
            },
            ghost_text = {
                enabled = true,
                show_with_selection = false,
                show_without_selection = true,
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                lsp = {
                    score_offset = 3,
                    min_keyword_length = 0, -- on manual trigger from 0 char lenght only LPS is showed
                    fallbacks = {},
                },
                path = {
                    score_offset = 0,
                    min_keyword_length = 3,
                    fallbacks = {},
                },
                snippets = {
                    score_offset = 0,
                    min_keyword_length = 2,
                    fallbacks = {},
                },
                buffer = {
                    score_offset = 1,
                    min_keyword_length = 3,
                    fallbacks = {},
                },
            },
        },
    },
    opts_extend = { "sources.default" },
}
