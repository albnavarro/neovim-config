return {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
        local tables_utils = require("utils/tables_utils")

        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                yaml = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
                jsonc = { "prettierd", "prettier", stop_after_first = true },
                scss = { "prettierd", "prettier", stop_after_first = true },
                html = { "prettierd", "prettier", stop_after_first = true },
                twig = { "prettierd", "prettier", stop_after_first = true },
                svelte = { "prettierd", "prettier", stop_after_first = true },
                vue = { "prettierd", "prettier", stop_after_first = true },
                pug = { "prettierd", "prettier", stop_after_first = true },
                -- Use the "*" filetype to run formatters on all filetypes.
                ["*"] = {},
                -- Use the "_" filetype to run formatters on filetypes that don't
                -- have other formatters configured.
                ["_"] = { "trim_whitespace" },
            },
            format_on_save = {},
            formatters = {
                prettierd = {
                    command = require("conform.util").find_executable(
                        { "node_modules/.bin/prettierd", "$XDG_DATA_HOME/nvim/mason/bin/prettierd" },
                        "prettierd"
                    ),
                },
                prettier = {
                    command = require("conform.util").find_executable(
                        { "node_modules/.bin/prettier", "$XDG_DATA_HOME/nvim/mason/bin/prettier" },
                        "prettier"
                    ),
                },
                stylelint = {
                    command = require("conform.util").find_executable(
                        { "node_modules/.bin/stylelint", "$XDG_DATA_HOME/nvim/mason/bin/stylelint" },
                        "stylelint"
                    ),
                },
                eslint_d = {
                    command = require("conform.util").find_executable(
                        { "node_modules/.bin/eslint_d", "$XDG_DATA_HOME/nvim/mason/bin/eslint_d" },
                        "eslint_d"
                    ),
                },
            },
        })

        local formatterTable = {
            {

                lang = { "scss", "css", "sass" },
                formatter = "stylelint",
            },
            {

                lang = { "javascript", "typescript" },
                formatter = "eslint_d",
            },
        }

        -- get treesitter languages
        local function getLanguages()
            local curline = vim.fn.line(".")
            return vim.treesitter.get_parser():language_for_range({ curline, 0, curline, 0 }):lang()
        end

        -- get formatter by lang
        local function getFormatter(lang)
            return tables_utils.find(formatterTable, function(item)
                return tables_utils.has_value(item.lang, lang)
            end)
        end

        -- format function
        local function customFormat(formatter, range)
            if range then
                require("conform").format(
                    { formatters = { formatter }, async = true, lsp_fallback = true, range = range },
                    function()
                        vim.cmd(":write")
                    end
                )
            else
                require("conform").format({ formatters = { formatter }, async = true, lsp_fallback = true }, function()
                    vim.cmd(":write")
                end)
            end
        end

        -- wholeFile formatter
        vim.api.nvim_create_user_command("FixWithLinter", function()
            -- local filetype = vim.bo.filetype

            local lang = getLanguages()
            local item = getFormatter(lang)

            if item == nil then
                return
            end

            customFormat(item.formatter, nil)
        end, {
            nargs = 0,
        })

        -- range formatter
        vim.api.nvim_create_user_command("FixWithLinterRange", function(args)
            -- local filetype = vim.bo.filetype

            local lang = getLanguages()
            local item = getFormatter(lang)

            if item == nil then
                return
            end

            -- get range.
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end

            customFormat(item.formatter, range)
        end, {
            range = true,
        })
    end,
}
