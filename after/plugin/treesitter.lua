local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

treesitter_configs.setup({
	ensure_installed = {
		"javascript",
		"typescript",
		"jsdoc",
		"css",
		"scss",
		"twig",
		"pug",
		"php",
		"json",
		"lua",
		"help",
		"vim",
		"svelte",
	},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
	},
	auto_tag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
