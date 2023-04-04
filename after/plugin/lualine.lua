local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- Set lualine as statusline
-- See `:help lualine.txt`
lualine.setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = "|",
		section_separators = "",
		"filename",
		-- path = 2,
	},
})
