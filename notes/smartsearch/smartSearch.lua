local V = vim
local A = V.api
local M = {
    concatenateRegex = [[.\{-}]],
    active = false,
}

-- Termcode convert utils
local function t(str)
    return A.nvim_replace_termcodes(str, true, true, true)
end

-- setup smart_search settings
local function initSettings()
    M.active = true
    V.cmd(':let @/ = ""')
    V.cmd(":set hlsearch")
end

-- remove smart_search settings
local function removeSettings()
    if M.active == true then
        M.active = false
        V.cmd(":set nohlsearch")
    end
end

-- return concatenateRegex on space press or default space
local function onSpacePressed()
    return (M.active == true) and M.concatenateRegex or t("<Space>")
end

-- get current line number
local function getCurrentLineNumber()
    return A.nvim_win_get_cursor(0)[1]
end

-- get top/bottom windows line
local function getWindowLineNumber(useFirstLine)
    if useFirstLine == true then
        return A.nvim_win_call(0, function()
            return V.fn.line("w0")
        end)
    else
        return A.nvim_win_call(0, function()
            return V.fn.line("w$")
        end)
    end
end

-- get case insensitive regex
local function getCase(value)
    return value == true and [[\c]] or ""
end

-- search down
local function searchDown(ignoreCase)
    local case = getCase(ignoreCase)

    return [[/]]
        .. case
        .. [[\%>]]
        .. getCurrentLineNumber() - 1
        .. [[l\%<]]
        .. getWindowLineNumber(false)
        .. [[l]]
        -- move curor to last selection
        .. [[/e]]
        .. t("<C-b>")
end

-- search up
local function searchUp(ignoreCase)
    local case = getCase(ignoreCase)

    return [[?]]
        .. case
        .. [[\%<]]
        .. getCurrentLineNumber() + 1
        .. [[l\%>]]
        .. getWindowLineNumber(true)
        .. [[l]]
        .. t("<C-b>")
end

-- ignore case
A.nvim_set_keymap("n", "<Leader>d", "", {
    noremap = true,
    silent = false,
    expr = true,
    callback = function()
        initSettings()
        return searchDown(true)
    end,
})

-- ignore case
A.nvim_set_keymap("n", "<Leader>u", "", {
    noremap = true,
    expr = true,
    callback = function()
        initSettings()
        return searchUp(true)
    end,
})

-- exact match
A.nvim_set_keymap("n", "<Leader>D", "", {
    noremap = true,
    silent = false,
    expr = true,
    callback = function()
        initSettings()
        return searchDown(false)
    end,
})

-- exact match
A.nvim_set_keymap("n", "<Leader>U", "", {
    noremap = true,
    expr = true,
    callback = function()
        initSettings()
        return searchUp(false)
    end,
})

A.nvim_set_keymap("c", "<Space>", "", {
    noremap = true,
    expr = true,
    callback = onSpacePressed,
})

-- clear setting on commandline leave
local smartSearchGrp = A.nvim_create_augroup("SearchConcatenate", { clear = true })
A.nvim_create_autocmd("CmdlineLeave", {
    callback = removeSettings,
    group = smartSearchGrp,
})
