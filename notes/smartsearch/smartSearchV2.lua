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

A.nvim_set_keymap("n", "<Leader>d", "", {
    noremap = true,
    silent = false,
    expr = true,
    callback = function()
        initSettings()
        return [[/\c\%>]] .. getCurrentLineNumber() - 1 .. [[l\%<]] .. getWindowLineNumber(false) .. [[l]] .. t("<C-b>")
    end,
})

A.nvim_set_keymap("n", "<Leader>u", "", {
    noremap = true,
    expr = true,
    callback = function()
        initSettings()
        return [[?\c\%<]] .. getCurrentLineNumber() + 1 .. [[l\%>]] .. getWindowLineNumber(true) .. [[l]] .. t("<C-b>")
    end,
})

-- clear setting on commandline leave
local smartSearchGrp = A.nvim_create_augroup("SearchConcatenate", { clear = true })
A.nvim_create_autocmd("CmdlineLeave", {
    callback = removeSettings,
    group = smartSearchGrp,
})

local keys = {
    [[q]],
    [[w]],
    [[e]],
    [[r]],
    [[t]],
    [[y]],
    [[u]],
    [[i]],
    [[o]],
    [[p]],
    [[a]],
    [[s]],
    [[d]],
    [[f]],
    [[g]],
    [[h]],
    [[j]],
    [[k]],
    [[l]],
    [[z]],
    [[x]],
    [[c]],
    [[v]],
    [[b]],
    [[n]],
    [[m]],
    [[1]],
    [[2]],
    [[3]],
    [[4]],
    [[5]],
    [[6]],
    [[7]],
    [[8]],
    [[9]],
    [[0]],
    [[(]],
    [[)]],
    [[{]],
    [[}]],
    "[",
    "]",
    [[;]],
    [[:]],
    [[']],
    [["]],
    [[<]],
    [[>]],
    [[,]],
    [[.]],
    [[/]],
    [[?]],
    [[`]],
    [[+]],
    [[=]],
    [[|]],
    [[\]],
    [[~]],
    [[!]],
    [[@]],
    [[#]],
    [[$]],
    [[%]],
    [[^]],
    [[&]],
    [[*]],
    [[-]],
    [[_]],
}

for _, key in ipairs(keys) do
    A.nvim_set_keymap("c", key, "", {
        noremap = true,
        expr = true,
        callback = function()
            return (M.active == true) and key .. M.concatenateRegex or key
        end,
    })
end
