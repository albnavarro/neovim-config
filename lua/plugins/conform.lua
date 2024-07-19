return {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
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
                pug = { "prettierd", "prettier", stop_after_first = true },
                -- Use the "*" filetype to run formatters on all filetypes.
                ["*"] = { "codespell" },
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

        -- Toggle codeSpell.
        local useCodeSpell = false
        require("conform.formatters.codespell").condition = function()
            return useCodeSpell
        end

        vim.api.nvim_create_user_command("CodeSpellFormatOn", function()
            useCodeSpell = true
        end, {})

        vim.api.nvim_create_user_command("CodeSpellFormatOff", function()
            useCodeSpell = false
        end, {})

        -- Fix eslint/stylelint.
        local stylelintFileType = { "scss", "css", "sass" }
        local eslintFileType = { "javascript", "typescript" }
        local tables_utils = require("utils/tables_utils")

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
            local filetype = vim.bo.filetype

            -- stylelint.
            if tables_utils.has_value(stylelintFileType, filetype) then
                customFormat("stylelint", nil)
            end

            -- eslint.
            if tables_utils.has_value(eslintFileType, filetype) then
                customFormat("eslint_d", nil)
            end
        end, {
            nargs = 0,
        })

        -- range formatter
        vim.api.nvim_create_user_command("FixWithLinterRange", function(args)
            local filetype = vim.bo.filetype

            -- get range.
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end

            -- stylelint.
            if tables_utils.has_value(stylelintFileType, filetype) then
                customFormat("stylelint", range)
            end

            -- eslint.
            if tables_utils.has_value(eslintFileType, filetype) then
                customFormat("eslint_d", range)
            end
        end, {
            range = true,
        })
    end,
}
