return {
	"mhartington/formatter.nvim",
	event = "VeryLazy",
	config = function()
		local util = require("formatter.util")
		local dir_utils = require("utils/dir_utils")
		local tables_utils = require("utils/tables_utils")

		-- Try to get Prettier for node_modules or get prettierd
		local P = dir_utils.getExePath("/node_modules/.bin/prettier", "prettierd")
		local prettierdConfigTryLocal = function()
			return {
				exe = P,
				args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()), "--single-quote" },
				stdin = true,
			}
		end

		-- Prettierd
		local prettierdConfig = function()
			return {
				exe = "prettierd",
				args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()), "--single-quote" },
				stdin = true,
			}
		end

		-- eslint_d
		local eslintdConfig = function()
			return {
				exe = "eslint_d",
				args = {
					"--stdin",
					"--stdin-filename",
					util.escape_path(util.get_current_buffer_file_path()),
					"--fix-to-stdout",
				},
				stdin = true,
			}
		end

		-- Stylelint
		local S = dir_utils.getExePath("/node_modules/.bin/stylelint", "stylelint")
		local stylelintConfig = function()
			return {
				exe = S,
				args = {
					"--fix",
					"--stdin",
					"--stdin-filename",
					util.escape_path(util.get_current_buffer_file_path()),
				},
				ignore_exitcode = true,
				stdin = true,
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
				scss = { require("formatter.filetypes.css").prettierd },
				twig = { prettierdConfig },
				pug = { prettierdConfigTryLocal },

				-- Fake filetype to format with stylelint.
				cssFake = { stylelintConfig },
				jsFake = { eslintdConfig },

				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})

		-- Execute stylelint only on specific filetype.
		-- Filtype is used to rpevent ignore_exitcode error on worng filetype.
		local stylelintFileType = { "scss", "css", "sass" }
		vim.api.nvim_create_user_command("Stylelint", function()
			local filetype = vim.bo.filetype
			if tables_utils.has_value(stylelintFileType, filetype) then
				vim.cmd("set filetype=" .. "cssFake") -- fake filetype
				vim.cmd(":Format")
				vim.cmd("set filetype=" .. filetype) -- restore original filetype
			end
		end, {
			nargs = 0,
		})

		-- Execute eslint
		vim.api.nvim_create_user_command("Eslintd", function()
			local filetype = vim.bo.filetype
			vim.cmd("set filetype=" .. "jsFake") -- fake filetype
			vim.cmd(":Format")
			vim.cmd("set filetype=" .. filetype) -- restore original filetype
		end, {
			nargs = 0,
		})

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
