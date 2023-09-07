-- Toggle macro with "q" key in normal mode.
-- Play macro in visual mode for each line with "q" key.

local V = vim
local A = V.api
local M = {
	active = false,
}

local function switchState()
	if M.active == true then
		M.active = false
		return "q"
	else
		M.active = true
		return "0qa"
	end
end

A.nvim_set_keymap("n", "Q", "", {
	noremap = true,
	silent = true,
	expr = true,
	callback = function()
		return switchState()
	end,
})

A.nvim_set_keymap("v", "Q", ":normal<Space>0@a<CR>", { noremap = true, silent = true })
