local NEXT_PROVIDER = require("custom.blink.next_provider")

return {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = {
        "rafamadriz/friendly-snippets",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    -- dependencies = {
    --     "L3MON4D3/LuaSnip",
    --     -- follow latest release.
    --     version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    --     dependencies = { "rafamadriz/friendly-snippets" },
    --     config = function()
    --         require("luasnip.loaders.from_vscode").lazy_load()
    --     end,
    -- },
    version = "v1.6.0",
    opts = {
        keymap = {
            preset = "default",
            ["<C-l>"] = {
                function(cmp)
                    -- switch to next provider.
                    cmp.show({ providers = { NEXT_PROVIDER.next() } })
                end,
            },
        },
        appearance = {
            nerd_font_variant = "normal",
            use_nvim_cmp_as_default = true,
        },
        -- snippets = {
        --     preset = "luasnip",
        -- },
        fuzzy = {
            sorts = { "exact", "score", "sort_text" },
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = false,
                },
            },
            trigger = {
                prefetch_on_insert = true,

                -- show_on_trigger_character = true,
                show_on_accept_on_trigger_character = false,
                -- show_on_blocked_trigger_characters = function()
                --     if vim.bo.filetype == "scss" then
                --         return { " ", "\n", "\t", "}" }
                --     end
                --
                --     return { " ", "\n", "\t" }
                -- end,
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
                -- enabled = true,
                enabled = false,
                show_without_selection = true,
            },
        },
        term = {
            enabled = false,
        },
        cmdline = {
            enabled = false,
        },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
                lsp = {
                    score_offset = 3,
                    min_keyword_length = function(ctx)
                        return ctx.trigger.kind == "manual" and 0 or 3
                    end,
                    fallbacks = {},
                },
                path = {
                    score_offset = 0,
                    min_keyword_length = 3,
                    fallbacks = {},
                },
                snippets = {
                    score_offset = 0,
                    min_keyword_length = 3,
                    fallbacks = {},
                },
                buffer = {
                    score_offset = 1,
                    min_keyword_length = 3,
                    fallbacks = {},
                    opts = {
                        get_bufnrs = function()
                            -- or filter to only "normal" buffers and NvimTree
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == "" or vim.bo[bufnr].filetype == "NvimTree"
                            end, vim.api.nvim_list_bufs())
                        end,
                    },
                },
            },
        },
    },
    opts_extend = { "sources.default" },
}
