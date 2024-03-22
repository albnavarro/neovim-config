return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        {
            --snippets
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            -- cmp sources plugins
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
        },
    },
    event = "InsertEnter",
    config = function()
        ---
        -- Snippet engine setup
        ---
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local luaVsCode = require("luasnip.loaders.from_vscode")

        luasnip.config.set_config({
            region_check_events = "InsertEnter",
            delete_check_events = "InsertLeave",
        })

        luaVsCode.lazy_load()

        -- add html snippet to twig.
        luasnip.filetype_extend("twig", { "html" })

        ---
        -- Autocompletion
        ---
        local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

        local cmp_config = {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = "path" },
                { name = "nvim_lsp", keyword_length = 3 },
                {
                    name = "buffer",
                    keyword_length = 3,
                    -- use on visible buffer
                    option = {
                        get_bufnrs = function()
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                bufs[vim.api.nvim_win_get_buf(win)] = true
                            end
                            return vim.tbl_keys(bufs)
                        end,
                    },
                },
                { name = "luasnip", keyword_length = 2 },
            },
            window = {
                documentation = vim.tbl_deep_extend("force", cmp.config.window.bordered(), {
                    max_height = 15,
                    max_width = 60,
                }),
                completion = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "abbr", "menu", "kind" },
                format = function(entry, item)
                    local short_name = {
                        nvim_lsp = "LSP",
                        nvim_lua = "nvim",
                    }

                    local menu_name = short_name[entry.source.name] or entry.source.name

                    item.menu = string.format("[%s]", menu_name)
                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ["<C-n>"] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- scroll the documentation window [b]ack / [f]orward
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ["<C-Space>"] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            }),
        }

        cmp.setup(cmp_config)
    end,
}
