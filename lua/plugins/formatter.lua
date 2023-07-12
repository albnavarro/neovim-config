return {
	"mhartington/formatter.nvim",
	event = "VeryLazy",
	config = function()
		local util = require("formatter.util")
		local prettierConfig = function()
			return {
				exe = "prettier",
				args = { util.escape_path(util.get_current_buffer_file_path()) },
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
				twig = { prettierConfig },
				pug = { prettierConfig },
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
