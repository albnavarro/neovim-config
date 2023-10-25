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
local blue = "#1561b8"
local grey_blue = "#38618c"
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
local dark_purple = "#442b48"
local white = "#ffffff"
local black = "#000000"
local cyan = "#007872"

g.terminal_color_0 = dark_purple
g.terminal_color_1 = red
g.terminal_color_2 = green
g.terminal_color_3 = yellow
g.terminal_color_4 = blue
g.terminal_color_5 = purple
g.terminal_color_6 = cyan
g.terminal_color_7 = grey

g.terminal_color_8 = dark_purple
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
	BlackOnLightYellow = { fg = dark_purple, bg = light_yellow },
	LightRedBackground = { bg = light_red },
	WhiteOnBlue = { fg = white, bg = blue },
	WhiteOnOrange = { fg = white, bg = orange },
	WhiteOnRed = { fg = white, bg = red },
	WhiteOnYellow = { fg = white, bg = yellow },
	Yellow = { fg = yellow, bold = true },
	Bold = { fg = dark_purple, bold = true },
	Boolean = { link = "Keyword" },
	Character = { link = "String" },
	ColorColumn = { bg = highlight },
	Comment = { fg = medium_grey },
	Conceal = {},
	Constant = { fg = dark_purple },
	Cursor = { bg = dark_purple },
	-- This is to work around https://github.com/neovim/neovim/issues/9800.
	CursorLine = { ctermfg = "black" },
	CursorLineNr = { fg = dark_purple, bold = true },
	Directory = { fg = dark_purple },
	EndOfBuffer = { fg = background, bg = background },
	Error = { link = "ErrorMsg" },
	ErrorMsg = { fg = red, bold = true },
	FoldColumn = { fg = light_grey, bg = background },
	Folded = { link = "Comment" },
	Identifier = { fg = dark_purple },
	IncSearch = { bg = light_yellow },
	Include = { fg = dark_purple, bold = true },
	InstanceVariable = { fg = purple },
	Keyword = { fg = dark_purple },
	Label = { link = "Keyword" },
	LineNr = { fg = medium_grey },
	Macro = { fg = orange },
	MatchParen = { bold = true },
	MoreMsg = { fg = dark_purple },
	MsgSeparator = { fg = border },
	NonText = { fg = grey },
	Normal = { fg = dark_purple, bg = background },
	NormalFloat = { fg = dark_purple, bg = background },
	TerminalFloat = { fg = dark_purple, bg = grey_bg_light },
	Number = { fg = dark_purple },
	Operator = { fg = dark_purple },
	Pmenu = { fg = dark_purple, bg = grey_bg_light },
	PmenuSbar = { bg = grey_bg_light },
	PmenuSel = { fg = dark_purple, bg = light_grey, bold = true },
	PmenuThumb = { bg = dark_purple },
	PreCondit = { link = "Macro" },
	PreProc = { fg = dark_purple },
	Question = { fg = dark_purple },
	QuickFixLine = { bg = highlight, bold = true },
	Regexp = { fg = orange },
	Search = { bg = light_yellow },
	SignColumn = { link = "FoldColumn" },
	Special = { fg = dark_purple },
	SpecialKey = { link = "Number" },
	SpellBad = { fg = red, bold = true, underline = true },
	SpellCap = { fg = purple, underline = true },
	SpellLocal = { fg = green, underline = true },
	SpellRare = { fg = purple, underline = true },
	Statement = { link = "Keyword" },
	-- Lualine ^^^^^^ problem derive by this settings.
	-- StatusLine = { fg = background, bg = black },
	-- StatusLineNC = { fg = background, bg = black },
	StatusLineTab = { fg = background, bg = dark_purple },
	WinBar = { fg = dark_purple, bg = light_grey, bold = true },
	WinBarNc = { fg = dark_purple, bold = true },
	WinBarFill = { fg = border },
	StorageClass = { link = "Keyword" },
	String = { fg = yellow },
	Symbol = { fg = orange },
	TabLine = { fg = dark_purple, bg = light_grey },
	TabLineFill = { fg = dark_purple, bg = border },
	TabLineSel = { fg = dark_purple, bg = background, bold = true },
	Title = { fg = dark_purple, bold = true },
	Todo = { fg = grey, bold = true },
	Type = { link = "Constant" },
	Underlined = { underline = true },
	VertSplit = { fg = border },
	Visual = { bg = light_grey },
	WarningMsg = { fg = yellow, bold = true },
	WildMenu = { link = "PmenuSel" },

	-- Diffs
	DiffAdd = { fg = dark_purple, bg = background },
	DiffChange = { fg = border, bg = background },
	DiffDelete = { fg = red, bg = background },
	DiffText = { fg = dark_purple, bg = background },
	diffAdded = { link = "DiffAdd", bg = background },
	diffChanged = { link = "DiffChange", bg = background },
	diffFile = { fg = dark_purple, bold = true },
	diffLine = { fg = blue },
	diffRemoved = { link = "DiffDelete" },

	-- LSP
	DiagnosticUnderlineError = { underline = true, sp = red },
	DiagnosticUnderlineWarn = { underline = true, sp = yellow },
	LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError" },
	LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarn" },
	DiagnosticFloatingError = { fg = red, bg = background, bold = true },
	DiagnosticFloatingHint = { fg = dark_purple, bg = background, bold = true },
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
	NvimTreeCursorLine = { bg = white, fg = dark_purple },
	NvimTreeCursorLineNr = { fg = dark_purple, bg = dark_purple },
	NvimTreeCursorColumn = { fg = dark_purple },
	NvimTreeWinSeparator = { bg = grey_bg_light, fg = grey_bg_light },
	NvimTreeFileIcon = { fg = dark_purple },
	NvimTreeOpenedFileIcon = { fg = dark_purple },
	NvimTreeSymlinkIcon = { fg = dark_purple },
	NvimTreeFolderIcon = { fg = dark_purple },
	NvimTreeOpenedFolderIcon = { fg = dark_purple },
	NvimTreeClosedFolderIcon = { fg = dark_purple },
	NvimTreeFolderArrowClosed = { fg = dark_purple },
	NvimTreeFolderArrowOpen = { fg = dark_purple },
	NvimTreeSpecialFile = { fg = dark_purple },

	-- Lazy.nvim
	LazyNormal = { bg = background },

	-- HTML
	htmlArg = { link = "Identifier" },
	htmlLink = { link = "Directory" },
	htmlScriptTag = { link = "htmlTag" },
	htmlSpecialTagName = { link = "htmlTag" },
	htmlTag = { fg = dark_purple, bold = true },
	htmlTagName = { link = "htmlTag" },
	htmlItalic = { italic = true },
	htmlBold = { bold = true },

	-- Javascript
	JavaScriptNumber = { link = "Number" },
	javaScriptBraces = { link = "Operator" },
	javaScriptFunction = { link = "Keyword" },
	javaScriptIdentifier = { link = "Keyword" },
	javaScriptMember = { link = "Identifier" },

	-- Treesitter
	["@keyword"] = { fg = dark_purple },
	["@keyword.jsdoc"] = { link = "comment" },
	["@type.jsdoc"] = { link = "comment" },
	["@parameter"] = { fg = dark_purple, bold = false },
	["@property"] = { fg = dark_purple, italic = true },
	["@property.scss"] = { fg = dark_purple, italic = false },
	["@property.css"] = { fg = dark_purple, italic = false },
	["@property.pug"] = { fg = dark_purple, italic = false },
	["@punctuation.delimiter"] = { fg = dark_purple, bold = true },
	["@function"] = { fg = black, bold = true },
	["@function.call"] = { fg = black, bold = true },
	["@method"] = { fg = black, bold = true },
	["@method.call"] = { fg = black, bold = true },
	["@function.builtin"] = { fg = black, bold = true },
	["@keyword.javascript"] = { fg = grey_blue, bold = true },
	["@keyword.function"] = { fg = black, bold = true },
	["@method.function"] = { fg = black, bold = true },
	["@type.javascript"] = { fg = dark_grey },
	["@comment"] = { fg = medium_grey, bold = false },
	["@tag.html"] = { link = "htmlTag" },
	["@tag.delimiter.html"] = { fg = dark_purple },
	["@tag.svelte"] = { link = "htmlTag" },
	["@tag.delimiter"] = { bold = false },
	["@tag.attribute"] = { fg = dark_grey, bold = false },
	["@lsp.type.parameter"] = { fg = dark_purple, bold = false },
	["@lsp.type.property"] = { fg = dark_purple, italic = true },
	["@lsp.type.property.lua"] = { fg = dark_purple, italic = false },
	["@lsp.type.punctuation.delimiter"] = { fg = dark_purple, bold = true },
	["@lsp.type.function"] = { fg = black, bold = true },
	["@lsp.type.function.call"] = { fg = black, bold = true },
	["@lsp.type.method"] = { fg = black, bold = true },
	["@lsp.type.method.call"] = { fg = black, bold = true },
	["@lsp.type.function.builtin"] = { fg = black, bold = true },
	["@lsp.type.keyword.function"] = { fg = black, bold = true },
	["@lsp.type.method.function"] = { fg = black, bold = true },
}

-- Apply highrlight group
for group, opts in pairs(highlights) do
	api.nvim_set_hl(0, group, opts)
end

-- Reset lsp semantic Highlight
-- Is slow and override custom highlight
-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
-- 	vim.api.nvim_set_hl(0, group, {})
-- end

--- Terminal theme
vim.api.nvim_create_augroup("_terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	command = "setlocal winhighlight=Normal:TerminalFloat",
	group = "_terminal",
})

-- Lualine integration
local mobbuLine = {}

mobbuLine.normal = {
	a = { bg = dark_purple, fg = background },
	b = { bg = light_grey, fg = dark_purple },
	c = { bg = light_grey, fg = dark_purple },
}

mobbuLine.insert = {
	a = { bg = blue, fg = background },
}
--
mobbuLine.command = {
	a = { bg = yellow, fg = dark_purple },
}

mobbuLine.visual = {
	a = { bg = light_green, fg = dark_purple },
}
--
-- mobbuLine.replace = {
--   a = {},
--   b = {},
-- }
--
mobbuLine.terminal = {
	a = { bg = dark_purple, fg = background },
	b = { bg = dark_purple, fg = background },
}
--
mobbuLine.inactive = {
	a = { bg = dark_purple, fg = white },
	b = { bg = dark_purple, fg = white },
	c = { bg = dark_purple, fg = white },
}

for _, mode in pairs(mobbuLine) do
	mode.a.gui = "bold"
end

return mobbuLine
