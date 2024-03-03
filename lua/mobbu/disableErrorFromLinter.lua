local ESLINT = "eslint_d"
local STYLELINT = "stylelint"

local function disableEslintLine(error)
	return "// eslint-disable-next-line " .. error
end

local function disableStylelint(error)
	return "/* stylelint-disable-next-line " .. error .. " */"
end

local function redirectByLinter(source, code, spaces)
	if source == ESLINT then
		return spaces .. disableEslintLine(code)
	end

	if source == STYLELINT then
		return spaces .. disableStylelint(code)
	end
end

vim.api.nvim_create_user_command("DisableError", function()
	local lineNum = vim.api.nvim_win_get_cursor(0)[1]
	local colStart = vim.fn.getline("."):find("%S")
	local diagnostic = vim.diagnostic.get(0, { lnum = lineNum - 1 })

	-- get size of table
	local size = 0
	for _ in pairs(diagnostic) do
		size = size + 1
	end

	-- TODO use better way to col start instead spaces
	local spaces = string.rep(" ", colStart - 1)

	-- Inizialize local variable
	local errorResult = ""
	local source = ""
	local index = 0

	for _, item in ipairs(diagnostic) do
		if item.source == ESLINT or item.source == STYLELINT then
			-- Check if there is multiple error
			-- In case separate every error with a comma
			local comma = index == 0 and "" or ","

			-- Concatenate errors
			if item.code then
				errorResult = errorResult .. comma .. item.code
			end

			-- get source, eslint or stylelint
			source = item.source

			index = index + 1
		end
	end

	vim.api.nvim_buf_set_lines(0, lineNum - 1, lineNum - 1, false, { redirectByLinter(source, errorResult, spaces) })
end, {})
