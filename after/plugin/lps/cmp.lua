---
-- Snippet engine setup
---
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

luasnip.config.set_config({
	region_check_events = "InsertEnter",
	delete_check_events = "InsertLeave",
})

require("luasnip.loaders.from_vscode").lazy_load()

-- add twig snippet in html.
luasnip.filetype_extend("html", { "twig" })

---
-- Autocompletion
---
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

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
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

		-- scroll up and down in the completion documentation
		["<C-d>"] = cmp.mapping.scroll_docs(5),
		["<C-u>"] = cmp.mapping.scroll_docs(-5),

		-- go to next placeholder in the snippet
		["<C-n>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- go to previous placeholder in the snippet
		["<C-p>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- when menu is visible, navigate to next item
		-- when line is empty, insert a tab character
		-- else, activate completion
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(cmp_select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),

		-- when menu is visible, navigate to previous item on list
		-- else, revert to default behavior
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(cmp_select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
}

cmp.setup(cmp_config)
