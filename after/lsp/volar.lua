local U = require("utils/tables_utils")

-- local typescript
local function get_local_typescript_server_path(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])
    return project_root and vim.fs.joinpath(project_root, "node_modules", "typescript", "lib") or ""
end

-- typescript lib in order of priority
local pathsTable = {
    {
        package = "vtsls",
        path = "/node_modules/@vtsls/language-server/node_modules/typescript/lib",
    },
    {
        package = "typescript-language-server",
        path = "/node_modules/typescript/lib/",
    },
    {
        package = "vue-language-server",
        path = "/node_modules/typescript/lib",
    },
}

-- get table with lib paths
local paths = U.map(pathsTable, function(item)
    return require("mason-registry").get_package(item.package):get_install_path() .. item.path
end)

return {
    before_init = function(_, config)
        if config.init_options and config.init_options.typescript and config.init_options.typescript.tsdk == "" then
            -- add local lib in first tposition
            table.insert(paths, 1, get_local_typescript_server_path(config.root_dir))

            -- print(vim.inspect(paths))

            -- Find first valid path in priority order.
            local firstValidPath = U.find(paths, function(path)
                return vim.fn.isdirectory(path) ~= 0
            end)

            -- print(firstValidPath)

            config.init_options.typescript.tsdk = firstValidPath
        end
    end,
}
