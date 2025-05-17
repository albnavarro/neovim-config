local U = require("utils/nvim_utils")
local replace = require("custom.replace_in_quickfix")

-- Main module
local M = {}

-- Live grep in glob.
-- https://www.reddit.com/r/neovim/comments/tpnt3c/how_can_i_customize_telescope_to_only_grep_for_1/
local live_grep_in_glob = function(glob_pattern)
    require("telescope.builtin").live_grep({
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            replace.get_case_search(),
            "--glob=" .. (glob_pattern or ""),
        },
    })
end

function M.live_grep_in_glob()
    vim.ui.input({ prompt = "Glob: ", completion = "file", default = "**/*." }, live_grep_in_glob)
end

-- Search for exact word in visual mode.
function M.exact_search_visual()
    require("telescope.builtin").live_grep({
        default_text = U.getVisualSelection(),
        only_sort_text = true,
        additional_args = function()
            return { "--pcre2" }
        end,
    })
end

-- Find in specific folder.
function M.find_in_specific_folder()
    local path = ""

    vim.ui.input({ prompt = "Enter path: ", default = vim.fn.expand("%:h"), completion = "file" }, function(input)
        if input ~= nil then
            path = input
        end
    end)

    return ":Telescope live_grep search_dirs=" .. path
end

return M
