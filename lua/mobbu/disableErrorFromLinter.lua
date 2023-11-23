local function disableEslintLine(error)
	return "// eslint-disable-next-line " .. error
end

local function disableStylelint(error)
	return "/* stylelint-disable-next-line " .. error .. " */"
end

local function redirectByLinter(source, code)
	if source == "eslint_d" then
		return disableEslintLine(code)
	end

	if source == "stylelint" then
		return disableStylelint(code)
	end
end

vim.api.nvim_create_user_command("DisableError", function()
	local lineNum = vim.api.nvim_win_get_cursor(0)[1]
	local diagnostic = vim.diagnostic.get(0, { lnum = lineNum - 1 })

	for _, item in ipairs(diagnostic) do
		vim.api.nvim_buf_set_lines(0, lineNum - 1, lineNum - 1, false, { redirectByLinter(item.source, item.code) })
	end
end, {})
