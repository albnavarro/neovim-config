return {
	"gbprod/nord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nord").setup({})
		vim.cmd.colorscheme("nord")

		-- vim.cmd([[
		--           " tree-sitter "standard capture names"
		--           hi link @variable.parameter         @parameter
		--           hi link @variable.member            @field
		--           hi link @module                     @namespace
		--           hi link @number.float               @float
		--           hi link @string.special.symbol      @symbol
		--           hi link @string.regexp              @string.regex
		--           hi link @markup.strong              @text.strong
		--           hi link @markup.italic              @text.emphasis
		--           hi link @markup.underline           @text.underline   " note: some are changed to @string.special
		--           hi link @markup.strikethrough       @text.strike
		--           hi link @markup.heading             @text.title
		--           hi link @markup.quote               @text.quote
		--           hi link @markup.link.url            @text.uri
		--           hi link @markup.math                @text.math
		--           hi link @markup.environment         @text.environment
		--           hi link @markup.environment.name    @text.environment.name
		--           hi link @markup.link                @text.reference
		--           hi link @markup.raw                 @text.literal
		--           hi link @markup.raw.block           @text.literal.block
		--           hi link @markup.link.label          @string.special
		--           hi link @markup.list                @punctuation.special
		--
		--           " Helix captures
		--           hi link @function.method            @method
		--           hi link @function.method.call       @method.call
		--           hi link @comment.todo               @text.todo
		--           hi link @comment.error              @text.danger
		--           hi link @comment.warning            @text.warning
		--           hi link @comment.hint               @text.note
		--           hi link @comment.info               @text.note
		--           hi link @comment.note               @text.note
		--           hi link @comment.ok                 @text.note
		--           hi link @diff.plus                  @text.diff.add
		--           hi link @diff.minus                 @text.diff.delete
		--           hi link @diff.delta                 @text.diff.change
		--           hi link @string.special.url         @text.uri
		--           hi link @keyword.directive          @preproc
		--           hi link @keyword.storage            @storageclass
		--           hi link @keyword.directive          @define
		--           hi link @keyword.conditional        @conditional
		--           hi link @keyword.debug              @debug
		--           hi link @keyword.exception          @exception
		--           hi link @keyword.import             @include
		--           hi link @keyword.repeat             @repeat
		--
		--           " --------------------
		--           " Your 'legacy' colorscheme, e.g.
		--           " hi! @parameter               guifg=#5fafff
		--       ]])
	end,
}
