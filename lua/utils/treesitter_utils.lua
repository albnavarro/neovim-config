local M = {} -- initialize an empty table (or object in JS terms)

function M.getTSLanguages()
    local curline = vim.fn.line(".")
    return vim.treesitter.get_parser():language_for_range({ curline, 0, curline, 0 }):lang()
end

return M -- This line exports the table
