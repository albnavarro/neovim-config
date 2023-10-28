return {
	"ronisbr/nano-theme.nvim",
	init = function()
		local api = vim.api
		local opt = vim.opt
		local cmd = vim.cmd

		opt.background = "light" -- or "dark".
		cmd.colorscheme("nano-theme")

		-- Override
		local function overrideHighlight()
			local c = require("nano-theme.colors").get()

			local override = {
				EndOfBuffer = { fg = c.nano_background_color, bg = c.nano_background_color },
			}

			for group, opts in pairs(override) do
				api.nvim_set_hl(0, group, opts)
			end
		end

		local colorSchemeGroup = api.nvim_create_augroup("OverrideColorScheme", { clear = true })
		api.nvim_create_autocmd("colorscheme", {
			callback = function()
				overrideHighlight()
			end,
			group = colorSchemeGroup,
		})

		overrideHighlight()
	end,
}
