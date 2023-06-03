local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
	return
end

local status_config_ok, config = pcall(require, "neoscroll.config")
if not status_config_ok then
	return
end

neoscroll.setup({
	mappings = { "<C-u>", "<C-d>", "<C-e>", "<C-y>" },
})

local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }

config.set_mappings(t)
