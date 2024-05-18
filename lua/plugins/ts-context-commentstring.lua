return {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
        require("ts_context_commentstring").setup({
            enable_autocmd = false,
        })

        vim.schedule(function()
            local get_option = vim.filetype.get_option
            vim.filetype.get_option = function(filetype, option)
                return option == "commentstring"
                        and require("ts_context_commentstring.internal").calculate_commentstring()
                    or get_option(filetype, option)
            end
        end)
    end,
}

-- Lazyvim slution to use this plugin with native comment:
-- https://github.com/LazyVim/LazyVim/commit/1d23c98da138494fafdad6735d70c3d3375bb7b2
-- https://github.com/LazyVim/LazyVim/commit/c653c4a9a5c0a3cd5101ce86a3640ee12067ffcd
