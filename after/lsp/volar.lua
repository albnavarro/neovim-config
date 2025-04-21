-- local typescript
local function get_local_typescript_server_path(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])
    return project_root and vim.fs.joinpath(project_root, "node_modules", "typescript", "lib") or ""
end

-- mason vtsls typescript
local function get_mason_vtsls_typescript_server_path()
    return require("mason-registry").get_package("vtsls"):get_install_path()
        .. "/node_modules/@vtsls/language-server/node_modules/typescript/lib"
end

-- mason ts_ls typescript
local function get_mason_ts_ls_typescript_server_path()
    return require("mason-registry").get_package("typescript-language-server"):get_install_path()
        .. "/node_modules/typescript/lib/"
end

-- mason vue typescript
local function get_mason_vue_typescript_server_path()
    return require("mason-registry").get_package("vue-language-server"):get_install_path()
        .. "/node_modules/typescript/lib"
end

return {
    before_init = function(_, config)
        if config.init_options and config.init_options.typescript and config.init_options.typescript.tsdk == "" then
            local localPath = get_local_typescript_server_path(config.root_dir)
            local vtslsPath = get_mason_vtsls_typescript_server_path()
            local tslsPath = get_mason_ts_ls_typescript_server_path()
            local vuePath = get_mason_vue_typescript_server_path()

            if vim.fn.isdirectory(localPath) ~= 0 then
                config.init_options.typescript.tsdk = localPath
            elseif vim.fn.isdirectory(vtslsPath) ~= 0 then
                config.init_options.typescript.tsdk = vtslsPath
            elseif vim.fn.isdirectory(tslsPath) ~= 0 then
                config.init_options.typescript.tsdk = tslsPath
            elseif vim.fn.isdirectory(vuePath) ~= 0 then
                config.init_options.typescript.tsdk = vuePath
            end
        end
    end,
}
