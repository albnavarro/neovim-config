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
local light_grey = "#ececec"
local light_grey_1 = "#e3e3e3"
local light_grey_2 = "#cccccc"
local medium_grey = "#6e6e6e"
local grey = "#b3aaaa"
local dark_grey = "#706c6c"
local cyan = "#007872"
local grey_blue = "#38618c"
local blue = "#1561b8"
local green = "#41ad1c"
local dark_green = "#1C5708"
local red = "#c4331d"
local highlight = "#eeeeee"
local yellow = "#ede858"
local dark_yellow = "#bf8f00"
local brown = "#a55000"
local purple = "#5c21a5"
local purple_grey = "#442b48"
local white = "#ffffff"
local black = "#000000"

g.terminal_color_0 = purple_grey
g.terminal_color_1 = red
g.terminal_color_2 = dark_green
g.terminal_color_3 = dark_yellow
g.terminal_color_4 = blue
g.terminal_color_5 = purple
g.terminal_color_6 = cyan
g.terminal_color_7 = medium_grey

g.terminal_color_8 = purple_grey
g.terminal_color_9 = red
g.terminal_color_10 = dark_green
g.terminal_color_11 = dark_yellow
g.terminal_color_12 = blue
g.terminal_color_13 = purple
g.terminal_color_14 = cyan
g.terminal_color_15 = medium_grey

local highlights = {
	-- This highlight group can be used when one wants to disable a highlight
	-- group using `winhl`
	Disabled = {},
	--
	Bold = { bold = true },
	Boolean = { link = "Keyword" },
	Character = { link = "String" },
	ColorColumn = { bg = highlight },
	Comment = { fg = grey },
	Conceal = {},
	Constant = { fg = purple_grey },
	Cursor = { bg = black },
	-- This is to work around https://github.com/neovim/neovim/issues/9800.
	CursorLine = { ctermfg = "black" },
	CursorLineNr = { fg = purple_grey, bold = true },
	Directory = { fg = purple_grey },
	EndOfBuffer = { fg = background, bg = background },
	ErrorMsg = { fg = red, bold = true },
	Error = { link = "ErrorMsg" },
	FoldColumn = { fg = light_grey_1, bg = background },
	Folded = { link = "Comment" },
	Identifier = { fg = purple_grey },
	IncSearch = { bg = yellow },
	Include = { fg = purple_grey, bold = true },
	InstanceVariable = { fg = purple },
	Keyword = { fg = purple_grey },
	Label = { link = "Keyword" },
	LineNr = { fg = grey },
	Macro = { fg = brown },
	MatchParen = { bold = true },
	MoreMsg = { fg = purple_grey },
	MsgSeparator = { fg = light_grey_2 },
	NonText = { fg = medium_grey },
	Normal = { fg = purple_grey, bg = background },
	NormalFloat = { fg = purple_grey, bg = background },
	TerminalFloat = { fg = purple_grey, bg = light_grey },
	Number = { fg = green },
	Operator = { fg = purple_grey },
	Pmenu = { fg = purple_grey, bg = light_grey },
	PmenuSbar = { bg = light_grey },
	PmenuSel = { fg = purple_grey, bg = light_grey_1, bold = true },
	PmenuThumb = { bg = purple_grey },
	PreCondit = { link = "Macro" },
	PreProc = { fg = purple_grey },
	Question = { fg = purple_grey },
	QuickFixLine = { bg = highlight, bold = true },
	Regexp = { fg = brown },
	Search = { bg = yellow },
	SignColumn = { link = "FoldColumn" },
	Special = { fg = purple_grey },
	SpecialKey = { link = "Number" },
	SpellBad = { fg = red, bold = true, underline = true },
	SpellCap = { fg = purple, underline = true },
	SpellLocal = { fg = dark_green, underline = true },
	SpellRare = { fg = purple, underline = true },
	Statement = { link = "Keyword" },
	-- Lualine ^^^^^^ problem derive by this settings.
	-- StatusLine = { fg = background, bg = black },
	-- StatusLineNC = { fg = background, bg = black },
	StatusLineTab = { fg = background, bg = purple_grey },
	WinBar = { fg = purple_grey, bg = light_grey_1, bold = true },
	WinBarNc = { fg = purple_grey, bold = true },
	WinBarFill = { fg = light_grey_2 },
	StorageClass = { link = "Keyword" },
	String = { fg = dark_yellow },
	Symbol = { fg = brown },
	TabLine = { fg = purple_grey, bg = light_grey_1 },
	TabLineFill = { fg = purple_grey, bg = light_grey_2 },
	TabLineSel = { fg = purple_grey, bg = background, bold = true },
	Title = { fg = purple_grey, bold = true },
	Todo = { fg = medium_grey, bold = true },
	Type = { link = "Constant" },
	Underlined = { underline = true },
	VertSplit = { fg = light_grey_2 },
	Visual = { bg = light_grey_1 },
	WarningMsg = { fg = dark_yellow, bold = true },
	WildMenu = { link = "PmenuSel" },

	-- Diffs
	DiffAdd = { fg = purple_grey, bg = background },
	DiffChange = { fg = light_grey_2, bg = background },
	DiffDelete = { fg = red, bg = background },
	DiffText = { fg = purple_grey, bg = background },
	diffAdded = { link = "DiffAdd", bg = background },
	diffChanged = { link = "DiffChange", bg = background },
	diffFile = { fg = purple_grey, bold = true },
	diffLine = { fg = blue },
	diffRemoved = { link = "DiffDelete" },

	-- LSP
	DiagnosticUnderlineError = { underline = true, sp = red },
	DiagnosticUnderlineWarn = { underline = true, sp = dark_yellow },
	LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError" },
	LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarn" },
	DiagnosticFloatingError = { fg = red, bg = background, bold = true },
	DiagnosticFloatingHint = { fg = purple_grey, bg = background, bold = true },
	DiagnosticFloatingInfo = { fg = blue, bg = background, bold = true },
	DiagnosticFloatingWarn = { fg = dark_yellow, bg = background, bold = true },
	DiagnosticError = { fg = red, bold = true },
	DiagnosticHint = { fg = medium_grey, bold = true },
	DiagnosticInfo = { fg = blue, bold = true },
	DiagnosticWarn = { fg = dark_yellow, bold = true },

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
	TSStringEscape = { fg = dark_green, bold = true },
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
	NvimTreeNormal = { bg = light_grey },
	NvimTreeLineNr = { fg = medium_grey },
	NvimTreeEndOfBuffer = { fg = light_grey, bg = light_grey },
	NvimTreeRootFolder = { fg = medium_grey },
	NvimTreeCursorLine = { bg = white, fg = purple_grey },
	NvimTreeCursorLineNr = { fg = purple_grey, bg = purple_grey },
	NvimTreeCursorColumn = { fg = purple_grey },
	NvimTreeWinSeparator = { bg = light_grey, fg = light_grey },
	NvimTreeFileIcon = { fg = purple_grey },
	NvimTreeOpenedFileIcon = { fg = purple_grey },
	NvimTreeSymlinkIcon = { fg = purple_grey },
	NvimTreeFolderIcon = { fg = purple_grey },
	NvimTreeOpenedFolderIcon = { fg = purple_grey },
	NvimTreeClosedFolderIcon = { fg = purple_grey },
	NvimTreeFolderArrowClosed = { fg = purple_grey },
	NvimTreeFolderArrowOpen = { fg = purple_grey },
	NvimTreeSpecialFile = { fg = purple_grey },

	-- Lazy.nvim
	LazyNormal = { bg = background },

	-- HTML
	htmlArg = { link = "Identifier" },
	htmlLink = { link = "Directory" },
	htmlScriptTag = { link = "htmlTag" },
	htmlSpecialTagName = { link = "htmlTag" },
	htmlTag = { fg = purple_grey, bold = true },
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
	["@keyword"] = { fg = purple_grey },
	["@keyword.jsdoc"] = { link = "comment" },
	["@type.jsdoc"] = { link = "comment" },
	["@parameter"] = { fg = purple_grey, bold = false },
	["@property"] = { fg = purple_grey, italic = true },
	["@property.scss"] = { fg = purple_grey, italic = false },
	["@property.css"] = { fg = purple_grey, italic = false },
	["@property.pug"] = { fg = purple_grey, italic = false },
	["@punctuation.delimiter"] = { fg = purple_grey, bold = true },
	["@function"] = { fg = black, bold = true },
	["@function.call"] = { fg = black, bold = true },
	["@method"] = { fg = black, bold = true },
	["@method.call"] = { fg = black, bold = true },
	["@function.builtin"] = { fg = black, bold = true },
	["@keyword.javascript"] = { fg = grey_blue, bold = true },
	["@keyword.function"] = { fg = black, bold = true },
	["@method.function"] = { fg = black, bold = true },
	["@type.javascript"] = { fg = dark_grey },
	["@comment"] = { fg = grey, bold = false },
	["@tag.html"] = { link = "htmlTag" },
	["@tag.delimiter.html"] = { fg = purple_grey },
	["@tag.svelte"] = { link = "htmlTag" },
	["@tag.delimiter"] = { bold = false },
	["@tag.attribute"] = { fg = dark_grey, bold = false },
	["@lsp.type.parameter"] = { fg = purple_grey, bold = false },
	["@lsp.type.property"] = { fg = purple_grey, italic = true },
	["@lsp.type.property.lua"] = { fg = purple_grey, italic = false },
	["@lsp.type.punctuation.delimiter"] = { fg = purple_grey, bold = true },
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
	a = { bg = purple_grey, fg = background },
	b = { bg = light_grey_1, fg = purple_grey },
	c = { bg = light_grey_1, fg = purple_grey },
}

mobbuLine.insert = {
	a = { bg = blue, fg = background },
}
--
mobbuLine.command = {
	a = { bg = dark_yellow, fg = purple_grey },
}

mobbuLine.visual = {
	a = { bg = green, fg = purple_grey },
}
--
-- mobbuLine.replace = {
--   a = {},
--   b = {},
-- }
--
mobbuLine.terminal = {
	a = { bg = purple_grey, fg = background },
	b = { bg = purple_grey, fg = background },
}
--
mobbuLine.inactive = {
	a = { bg = purple_grey, fg = white },
	b = { bg = purple_grey, fg = white },
	c = { bg = purple_grey, fg = white },
}

for _, mode in pairs(mobbuLine) do
	mode.a.gui = "bold"
end

return mobbuLine
