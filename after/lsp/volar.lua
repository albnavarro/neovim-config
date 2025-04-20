local function get_local_typescript_server_path(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])
    return project_root and vim.fs.joinpath(project_root, "node_modules", "typescript", "lib") or ""
end

local function get_mason_vtsls_typescript_server_path()
    return require("mason-registry").get_package("vtsls"):get_install_path()
        .. "/node_modules/@vtsls/language-server/node_modules/typescript/lib"
end

local function get_mason_vue_typescript_server_path()
    return require("mason-registry").get_package("vue-language-server"):get_install_path()
        .. "/node_modules/typescript/lib"
end

local volar_init_options = {
    vue = {
        hybridMode = true,
    },
    typescript = {
        tsdk = "",
    },
}

return {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json" },
    init_options = volar_init_options,
    before_init = function(_, config)
        if config.init_options and config.init_options.typescript and config.init_options.typescript.tsdk == "" then
            local localPath = get_local_typescript_server_path(config.root_dir)
            local vtslsPath = get_mason_vtsls_typescript_server_path()
            local vuePath = get_mason_vue_typescript_server_path()

            if vim.fn.isdirectory(localPath) ~= 0 then
                config.init_options.typescript.tsdk = localPath
                return
            elseif vim.fn.isdirectory(vtslsPath) ~= 0 then
                config.init_options.typescript.tsdk = vtslsPath
                return
            elseif vim.fn.isdirectory(vuePath) ~= 0 then
                config.init_options.typescript.tsdk = vuePath
            end
        end
    end,
}
