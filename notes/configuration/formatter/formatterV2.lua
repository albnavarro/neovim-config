return {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    config = function()
        local util = require("formatter.util")
        local dir_utils = require("utils/dir_utils")
        local defaults = require("formatter.defaults")

        -- Try to get Prettier for node_modules or get prettierd until try_node_modules become active.
        local P = dir_utils.getExePath("/node_modules/.bin/prettier", "prettierd")
        local prettierdConfigTryLocal = function()
            return {
                exe = P,
                args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()), "--single-quote" },
                stdin = true,
                try_node_modules = true,
            }
        end

        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = { require("formatter.filetypes.lua").stylua },
                typescript = { require("formatter.filetypes.typescript").prettierd },
                javascript = { require("formatter.filetypes.javascript").prettierd },
                yaml = { require("formatter.filetypes.yaml").prettierd },
                json = { require("formatter.filetypes.json").prettierd },
                jsonc = { require("formatter.filetypes.json").prettierd },
                scss = { require("formatter.filetypes.css").prettierd },
                html = { require("formatter.filetypes.html").prettierd },
                twig = { util.copyf(defaults.prettierd) },
                svelte = { util.copyf(defaults.prettierd) },
                pug = { prettierdConfigTryLocal },

                -- Use the special "*" filetype for defining formatter configurations on
                -- any filetype
                ["*"] = {
                    require("formatter.filetypes.any").remove_trailing_whitespace,
                },
            },
        })

        -- Format with default formatter on save.
        vim.api.nvim_exec(
            [[
                augroup FormatAutogroup
                  autocmd!
                  autocmd BufWritePost * FormatWrite
                augroup END
            ]],
            true
        )
    end,
}
