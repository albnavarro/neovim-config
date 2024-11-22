local U = require("utils/tables_utils")
--
-- check uf current buffer has vtsls
local function hasVtsls(bufnr)
    local clients = vim.lsp.buf_get_clients(bufnr)

    return U.find(clients, function(client)
        return client.name == "vtsls"
    end)
end

-- Organiz Import
vim.api.nvim_create_user_command("OrganizeImports", function(evt)
    if not hasVtsls(evt.bufnr) then
        return
    end

    vim.lsp.buf.execute_command({
        command = "typescript.organizeImports",
        arguments = { vim.fn.expand("%:p") },
    })
end, {})

-- Select typescript version
vim.api.nvim_create_user_command("SelectTypeScriptVersion", function(evt)
    if not hasVtsls(evt.bufnr) then
        return
    end

    vim.lsp.buf.execute_command({
        command = "typescript.selectTypeScriptVersion",
    })
end, {})
