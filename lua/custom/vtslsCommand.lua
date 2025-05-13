-- check uf current buffer has vtsls
local function hasVtsls(bufnr)
    local clients = vim.lsp.get_clients(bufnr)

    return vim.iter(clients):find(function(client)
        return client.name == "vtsls"
    end)
end

-- Organiz Import
vim.api.nvim_create_user_command("OrganizeImports", function(evt)
    if not hasVtsls(evt.bufnr) then
        return
    end

    local ok = vim.lsp.buf_request_sync(0, "workspace/executeCommand", {
        command = "typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
    }, 3000)

    if not ok then
        print("Command timeout or failed to complete.")
    end
end, {})

-- Select typescript version
vim.api.nvim_create_user_command("SelectTypeScriptVersion", function(evt)
    if not hasVtsls(evt.bufnr) then
        return
    end

    vim.lsp.buf_request_sync(0, "workspace/executeCommand", {
        command = "typescript.selectTypeScriptVersion",
        arguments = { vim.api.nvim_buf_get_name(0) },
    }, 100)
end, {})
