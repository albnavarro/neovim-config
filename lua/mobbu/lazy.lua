vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"karb94/neoscroll.nvim",
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"lukas-reineke/indent-blankline.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyonight-storm")
		end,
		opts = {},
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},

	-- lsp
	"neovim/nvim-lspconfig",

	-- manson
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	--autocompletion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",

	--snippets
	"l3mon4d3/luasnip",
	"rafamadriz/friendly-snippets",

	--null-ls
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",
})
