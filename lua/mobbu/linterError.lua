local ESLINT = "eslint"
local ESLINT_D = "eslint_d"
local STYLELINT = "stylelint"
local tables_utils = require("utils/tables_utils")

local linters = {
    [ESLINT] = {
        pre = "// eslint-disable-next-line",
        after = "",
    },
    [ESLINT_D] = {
        pre = "// eslint-disable-next-line",
        after = "",
    },
    [STYLELINT] = {
        pre = "/* stylelint-disable-next-line ",
        after = " */",
    },
}

local function formatErrorByLinter(source, code, spaces)
    return spaces .. linters[source].pre .. " " .. code .. linters[source].after
end

vim.api.nvim_create_user_command("DisableLinterLineError", function()
    local lineNum = vim.api.nvim_win_get_cursor(0)[1]
    local colStart = vim.fn.getline("."):find("%S")
    local diagnostic = vim.diagnostic.get(0, { lnum = lineNum - 1 })

    -- TODO use better way to col start instead spaces
    local spaces = string.rep(" ", colStart - 1)

    -- Inizialize local variable
    local errorResult = ""
    local source = ""

    -- print(vim.inspect(diagnostic))

    -- filter only error from eslint/eslint_d or stylelint
    local diagnostiFiltered = {}
    for key, value in pairs(diagnostic) do
        if value.source == ESLINT or value.source == ESLINT_D or value.source == STYLELINT then
            table.insert(diagnostiFiltered, value)
        end
    end

    -- if no error skip
    if tables_utils.tableSize(diagnostiFiltered) == 0 then
        return
    end

    for index, item in ipairs(diagnostiFiltered) do
        -- print(vim.inspect(item))

        -- Check if there is multiple error
        -- In case separate every error with a comma
        local comma = index == 1 and "" or ","

        -- Concatenate errors
        if item.code then
            errorResult = errorResult .. comma .. item.code
        end

        -- get source, eslint or stylelint
        source = item.source
    end

    vim.api.nvim_buf_set_lines(0, lineNum - 1, lineNum - 1, false, { formatErrorByLinter(source, errorResult, spaces) })
end, {})
