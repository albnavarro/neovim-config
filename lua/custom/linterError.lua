local ESLINT = "eslint"
local ESLINT_D = "eslint_d"
local STYLELINT = "stylelint"
local SVELTE = "svelte"
local DEFAULT = "default"
local tables_utils = require("utils/tables_utils")

local linters = {
    [ESLINT] = {
        [DEFAULT] = {
            pre = "// eslint-disable-next-line",
            after = "",
        },
        [SVELTE] = {
            pre = "<!-- eslint-disable-next-line",
            after = " -->",
        },
    },
    [ESLINT_D] = {
        [DEFAULT] = {
            pre = "// eslint-disable-next-line",
            after = "",
        },
        [SVELTE] = {
            pre = "<!-- eslint-disable-next-line",
            after = " -->",
        },
    },
    [STYLELINT] = {
        [DEFAULT] = {
            pre = "/* stylelint-disable-next-line ",
            after = " */",
        },
    },
}

local function formatErrorByLinter(source, code, spaces, lang)
    local pre = linters[source][lang] and linters[source][lang].pre or linters[source][DEFAULT].pre
    local after = linters[source][lang] and linters[source][lang].after or linters[source][DEFAULT].after

    return spaces .. pre .. " " .. code .. after
end

vim.api.nvim_create_user_command("DisableLinterLineError", function()
    -- Get line number && column number
    local lineNum = vim.api.nvim_win_get_cursor(0)[1]
    local colStart = vim.fn.getline("."):find("%S")

    -- Get current lang in line
    local curline = vim.fn.line(".")
    local lang = vim.treesitter.get_parser():language_for_range({ curline, 0, curline, 0 }):lang()

    -- Empty line, exit
    if colStart == nil then
        print("empty line")
        return
    end

    local diagnostic = vim.diagnostic.get(0, { lnum = lineNum - 1 })
    local spaces = string.rep(" ", colStart - 1)

    -- Filter all error for buffer active linter
    local diagnostiFiltered = tables_utils.filterArray(diagnostic, function(item)
        -- Excat match ( eslint vs eslint_d )
        return item.source:match("^" .. ESLINT .. "$")
            or item.source:match("^" .. ESLINT_D .. "$")
            or item.source:match("^" .. STYLELINT .. "$")
    end)

    -- print(vim.inspect(diagnostiFiltered))

    -- if no error skip
    if tables_utils.tableSize(diagnostiFiltered) == 0 then
        print("no error found")
        return
    end

    -- get source ( eslint etc.. ), suppose is unoque per buffer
    -- so get source at fist item
    local source = diagnostiFiltered[1].source

    -- concatenate errors in one string
    local error = tables_utils.reduce(diagnostiFiltered, function(previous, current, index)
        local comma = index == 0 and "" or ","
        return previous .. comma .. current.code
    end, "")

    vim.api.nvim_buf_set_lines(0, lineNum - 1, lineNum - 1, false, { formatErrorByLinter(source, error, spaces, lang) })
end, {})
