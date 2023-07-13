return {
	"mhartington/formatter.nvim",
	event = "VeryLazy",
	config = function()
		local util = require("formatter.util")
		local mob_utils = require("utils/dir_utils")

		-- Try to get Prettier for node_modules or get prettierd
		local P = mob_utils.getExePath("/node_modules/.bin/prettier", "prettierd")
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

		-- local eslintdConfig = function()
		-- 	return {
		-- 		exe = "eslint_d",
		-- 		args = {
		-- 			"--stdin",
		-- 			"--stdin-filename",
		-- 			util.escape_path(util.get_current_buffer_file_path()),
		-- 			"--fix-to-stdout",
		-- 		},
		-- 		stdin = true,
		-- 	}
		-- end

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				typescript = { require("formatter.filetypes.typescript").prettierd },
				javascript = { require("formatter.filetypes.javascript").prettierd },
				-- javascript = { prettierdConfig, eslintdConfig },
				yaml = { require("formatter.filetypes.yaml").prettierd },
				json = { require("formatter.filetypes.json").prettierd },
				scss = { require("formatter.filetypes.css").prettierd },
				twig = { prettierdConfig },
				pug = { prettierdConfigTryLocal },

				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
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
