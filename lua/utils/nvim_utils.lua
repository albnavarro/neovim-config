local M = {} -- initialize an empty table (or object in JS terms)

-- get visual selection
function M.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ""
    end
end

-- get range
function M.gerRange(args)
    local range = nil

    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end

    return range
end

-- find executable in node modules, return path or name ( global fallback )
M.find_bin_in_node_modules = function(name)
    local node_modules_binary = vim.fn.findfile("node_modules/.bin/" .. name, ".;")

    if node_modules_binary ~= "" then
        return node_modules_binary
    end

    return name
end

-- check if command is excutable
function M.is_executable(cmd)
    return cmd and vim.fn.executable(cmd) == 1 or false
end

-- check if command is excutable and noty if not
function M.get_bin_with_warning(name)
    local cmd = M.find_bin_in_node_modules(name)

    if not M.is_executable(cmd) then
        vim.schedule(function()
            vim.notify(
                name .. " was not available or found in your node_modules or $PATH. Please run install and try again."
            )
        end)

        return false, cmd
    end

    return true, cmd
end

function M.use_vim_input_path(options)
    options = options or {}

    local default_path = options.path or ""
    local message = options.message or "Enter path:"

    local path = ""
    vim.ui.input({ prompt = message .. " ", default = default_path, completion = "file" }, function(input)
        if input ~= nil then
            path = input
        end
    end)

    return path
end

return M -- This line exports the table
