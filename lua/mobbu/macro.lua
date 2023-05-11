-- Macro on register a, use native q to stop recording

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

A.nvim_set_keymap("n", "q", "", {
	noremap = true,
	silent = true,
	expr = true,
	callback = function()
		return switchState()
	end,
})

A.nvim_set_keymap("v", "q", ":normal<Space>0@a<CR>", { noremap = true, silent = true })
