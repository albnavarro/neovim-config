local o = vim.o
local g = vim.g
local api = vim.api

vim.cmd("hi clear")

if g.syntax_on == 1 then
	vim.cmd("syntax reset")
end

o.background = "light"
g.colors_name = "mobbu"

local background = "#f2f2f2"
local grey_bg_light = "#ececec"
local black = "#000000"
local blue = "#1561b8"
local green = "#1C5708"
local light_green = "#41ad1c"
local light_red = "#f2d3cd"
local red = "#c4331d"
local grey = "#6e6e6e"
local light_grey = "#e3e3e3"
local medium_grey = "#b3aaaa"
local dark_grey = "#706c6c"
local border = "#cccccc"
local highlight = "#eeeeee"
local yellow = "#bf8f00"
local light_yellow = "#ede858"
local orange = "#a55000"
local purple = "#5c21a5"
local white = "#ffffff"
local cyan = "#007872"

g.terminal_color_0 = black
g.terminal_color_1 = red
g.terminal_color_2 = green
g.terminal_color_3 = yellow
g.terminal_color_4 = blue
g.terminal_color_5 = purple
g.terminal_color_6 = cyan
g.terminal_color_7 = grey

g.terminal_color_8 = black
g.terminal_color_9 = red
g.terminal_color_10 = green
g.terminal_color_11 = yellow
g.terminal_color_12 = blue
g.terminal_color_13 = purple
g.terminal_color_14 = cyan
g.terminal_color_15 = grey

local highlights = {
	-- This highlight group can be used when one wants to disable a highlight
	-- group using `winhl`
	Disabled = {},
	-- These highlight groups can be used for statuslines, for example when
	-- displaying ALE warnings and errors.
	BlackOnLightYellow = { fg = black, bg = light_yellow },
	LightRedBackground = { bg = light_red },
	WhiteOnBlue = { fg = white, bg = blue },
	WhiteOnOrange = { fg = white, bg = orange },
	WhiteOnRed = { fg = white, bg = red },
	WhiteOnYellow = { fg = white, bg = yellow },
	Yellow = { fg = yellow, bold = true },
	Bold = { fg = black, bold = true },
	Boolean = { link = "Keyword" },
	Character = { link = "String" },
	ColorColumn = { bg = highlight },
	Comment = { fg = medium_grey },
	Conceal = {},
	Constant = { fg = black },
	Cursor = { bg = black },
	-- This is to work around https://github.com/neovim/neovim/issues/9800.
	CursorLine = { ctermfg = "black" },
	CursorLineNr = { fg = black, bold = true },
	Directory = { fg = black },
	EndOfBuffer = { fg = background, bg = background },
	Error = { link = "ErrorMsg" },
	ErrorMsg = { fg = red, bold = true },
	FoldColumn = { fg = light_grey, bg = background },
	Folded = { link = "Comment" },
	Identifier = { fg = black },
	IncSearch = { bg = light_yellow },
	Include = { fg = black, bold = true },
	InstanceVariable = { fg = purple },
	Keyword = { fg = black, bold = true },
	Label = { link = "Keyword" },
	LineNr = { fg = medium_grey },
	Macro = { fg = orange },
	MatchParen = { bold = true },
	MoreMsg = { fg = black },
	MsgSeparator = { fg = border },
	NonText = { fg = grey },
	Normal = { fg = black, bg = background },
	NormalFloat = { fg = black, bg = background },
	TerminalFloat = { fg = black, bg = grey_bg_light },
	Number = { fg = blue },
	Operator = { fg = black },
	Pmenu = { fg = black, bg = grey_bg_light },
	PmenuSbar = { bg = grey_bg_light },
	PmenuSel = { fg = black, bg = light_grey, bold = true },
	PmenuThumb = { bg = black },
	PreCondit = { link = "Macro" },
	PreProc = { fg = black },
	Question = { fg = black },
	QuickFixLine = { bg = highlight, bold = true },
	Regexp = { fg = orange },
	Search = { bg = light_yellow },
	SignColumn = { link = "FoldColumn" },
	Special = { fg = black },
	SpecialKey = { link = "Number" },
	SpellBad = { fg = red, bold = true, underline = true },
	SpellCap = { fg = purple, underline = true },
	SpellLocal = { fg = green, underline = true },
	SpellRare = { fg = purple, underline = true },
	Statement = { link = "Keyword" },
	-- Lualine ^^^^^^ problem derive by this settings.
	-- StatusLine = { fg = background, bg = black },
	-- StatusLineNC = { fg = background, bg = black },
	StatusLineTab = { fg = background, bg = black },
	WinBar = { fg = black, bg = light_grey, bold = true },
	WinBarNc = { fg = black, bold = true },
	WinBarFill = { fg = border },
	StorageClass = { link = "Keyword" },
	String = { fg = green },
	Symbol = { fg = orange },
	TabLine = { fg = black, bg = light_grey },
	TabLineFill = { fg = black, bg = border },
	TabLineSel = { fg = black, bg = background, bold = true },
	Title = { fg = black, bold = true },
	Todo = { fg = grey, bold = true },
	Type = { link = "Constant" },
	Underlined = { underline = true },
	VertSplit = { fg = border },
	Visual = { bg = light_grey },
	WarningMsg = { fg = yellow, bold = true },
	WildMenu = { link = "PmenuSel" },

	-- Diffs
	DiffAdd = { fg = black, bg = background },
	DiffChange = { fg = border, bg = background },
	DiffDelete = { fg = red, bg = background },
	DiffText = { fg = black, bg = background },
	diffAdded = { link = "DiffAdd", bg = background },
	diffChanged = { link = "DiffChange", bg = background },
	diffFile = { fg = black, bold = true },
	diffLine = { fg = blue },
	diffRemoved = { link = "DiffDelete" },

	-- LSP
	DiagnosticUnderlineError = { underline = true, sp = red },
	DiagnosticUnderlineWarn = { underline = true, sp = yellow },
	LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError" },
	LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarn" },
	DiagnosticFloatingError = { fg = red, bg = background, bold = true },
	DiagnosticFloatingHint = { fg = black, bg = background, bold = true },
	DiagnosticFloatingInfo = { fg = blue, bg = background, bold = true },
	DiagnosticFloatingWarn = { fg = yellow, bg = background, bold = true },
	DiagnosticError = { fg = red, bold = true },
	DiagnosticHint = { fg = grey, bold = true },
	DiagnosticInfo = { fg = blue, bold = true },
	DiagnosticWarn = { fg = yellow, bold = true },

	-- netrw
	netrwClassify = { link = "Identifier" },
	-- Telescope
	-- TelescopeBorder = {},
	-- TelescopeMatching = {},
	-- TelescopePromptNormal = {},
	-- TelescopePromptBorder = {},
	-- TelescopePromptPrefix = {},
	-- TelescopePromptTitle = {},
	-- TelescopeSelection = {},
	-- TelescopeTitle = {},
	-- TelescopeNormal = {},
	-- Treesitter

	-- Treesitter
	TSEmphasis = { italic = true },
	TSField = {},
	TSStringEscape = { fg = green, bold = true },
	TSStrong = { bold = true },
	TSURI = { fg = cyan, underline = true },
	TSUnderline = { underline = true },
	TSConstMacro = { link = "Macro" },
	TSDanger = { link = "Todo" },
	TSKeywordOperator = { link = "Keyword" },
	TSNamespace = { link = "Constant" },
	TSNote = { link = "Todo" },
	TSProperty = { link = "TSField" },
	TSStringRegex = { link = "Regexp" },
	TSSymbol = { link = "Symbol" },
	TSTypeBuiltin = { link = "Keyword" },
	TSWarning = { link = "Todo" },

	-- Nvimtree
	NvimTreeNormal = { bg = grey_bg_light },
	NvimTreeLineNr = { fg = grey },
	NvimTreeEndOfBuffer = { fg = grey_bg_light, bg = grey_bg_light },
	NvimTreeRootFolder = { fg = grey },

	-- Lazy.nvim
	LazyNormal = { bg = background },
}

-- Apply highrlight group
for group, opts in pairs(highlights) do
	api.nvim_set_hl(0, group, opts)
end

-- Reset lsp semantic Highlight
-- Is slow and override custom highlight
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
	vim.api.nvim_set_hl(0, group, {})
end

-- Add treesitter custom highlight
vim.api.nvim_set_hl(0, "@parameter.javascript", { fg = black, bold = true })
vim.api.nvim_set_hl(0, "@property.javascript", { fg = black, italic = true })
vim.api.nvim_set_hl(0, "@punctuation.delimiter.javascript", { fg = black, bold = true })
vim.api.nvim_set_hl(0, "@parameter.typescript", { fg = black, bold = true })
vim.api.nvim_set_hl(0, "@property.typescript", { fg = black, italic = true })
vim.api.nvim_set_hl(0, "@punctuation.delimiter.typescript", { fg = black, bold = true })

-- Function/Method
vim.api.nvim_set_hl(0, "@function", { fg = dark_grey })
vim.api.nvim_set_hl(0, "@function.call", { fg = dark_grey })
vim.api.nvim_set_hl(0, "@method", { fg = dark_grey })
vim.api.nvim_set_hl(0, "@method.call", { fg = dark_grey })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = dark_grey })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = dark_grey })
vim.api.nvim_set_hl(0, "@method.function", { fg = dark_grey })

-- JsDoc
vim.api.nvim_set_hl(0, "@type.javascript", { fg = dark_grey })

--- Terminal theme
vim.api.nvim_create_augroup("_terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	command = "setlocal winhighlight=Normal:TerminalFloat",
	group = "_terminal",
})

-- Lualine integration
local mobbuLine = {}

mobbuLine.normal = {
	a = { bg = black, fg = background },
	b = { bg = light_grey, fg = black },
	c = { bg = light_grey, fg = black },
}

mobbuLine.insert = {
	a = { bg = blue, fg = background },
}
--
mobbuLine.command = {
	a = { bg = yellow, fg = black },
}

mobbuLine.visual = {
	a = { bg = light_green, fg = black },
}
--
-- mobbuLine.replace = {
--   a = {},
--   b = {},
-- }
--
mobbuLine.terminal = {
	a = { bg = black, fg = background },
	b = { bg = black, fg = background },
}
--
mobbuLine.inactive = {
	a = { bg = black, fg = white },
	b = { bg = black, fg = white },
	c = { bg = black, fg = white },
}

for _, mode in pairs(mobbuLine) do
	mode.a.gui = "bold"
end

return mobbuLine
