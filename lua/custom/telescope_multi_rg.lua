-- Live grep in glob.
-- https://www.reddit.com/r/neovim/comments/tpnt3c/how_can_i_customize_telescope_to_only_grep_for_1/

local uv = vim.uv or vim.loop

local M = {}

local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local replace = require("custom.replace_in_quickfix")

-- i would like to be able to do telescope
-- and have telescope do some filtering on files and some grepping

function M.multi_rg(opts)
    opts = opts or {}
    opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or uv.cwd()
    opts.shortcuts = opts.shortcuts
        or {
            ["js"] = "*.js",
            ["svelte"] = "*.svelte",
            ["css"] = "*.css",
            ["scss"] = "*.scss",
            ["html"] = "*.html",
            ["json"] = "*.json",
            ["pug"] = "*.pug",
            ["twig"] = "*.twig",
            ["dir"] = vim.fn.expand("%:."),
        }
    opts.pattern = opts.pattern or "%s"

    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/finders.lua#L168
    local custom_grep = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local prompt_split = vim.split(prompt, "  ")

            local args = { "rg" }
            if prompt_split[1] then
                table.insert(args, "-e")
                table.insert(args, prompt_split[1])
            end

            if prompt_split[2] then
                table.insert(args, "-g")

                local pattern
                if opts.shortcuts[prompt_split[2]] then
                    pattern = opts.shortcuts[prompt_split[2]]
                else
                    pattern = prompt_split[2]
                end

                table.insert(args, string.format(opts.pattern, pattern))
            end

            -- from nvim 0.10 vim.tbl_flatten is deprecated ( soft )
            return vim.iter({
                args,
                {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    replace.getCaseSearch(),
                },
            })
                :flatten(math.huge)
                :totable()
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })

    pickers
        .new(opts, {
            debounce = 100,
            prompt_title = "Live Grep (with shortcuts)",
            finder = custom_grep,
            previewer = conf.grep_previewer(opts),
            sorter = require("telescope.sorters").empty(),
        })
        :find()
end

return M
