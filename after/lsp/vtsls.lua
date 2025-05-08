local function get_volar_config()
    -- local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
    local mason_packages = vim.fn.expand("$MASON/packages")
    local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

    return vim.fn.isdirectory(volar_path) == 1
            and {
                name = "@vue/typescript-plugin",
                location = volar_path,
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
            }
        or {}
end

return {
    filetypes = { "typescript", "javascript", "vue" },
    settings = {
        javascript = {
            preferences = {
                -- importModuleSpecifier = "non-relative",
            },
            inlayHints = {
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "all" },
                variableTypes = { enabled = true },
            },
        },
        typescript = {
            preferences = {
                -- importModuleSpecifier = "non-relative",
            },
        },
        vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
                -- Inlay hint truncation.
                maxInlayHintLength = 30,
                -- For completion performance.
                completion = {
                    enableServerSideFuzzyMatch = true,
                    entriesLimit = 50,
                },
            },
            tsserver = {
                globalPlugins = {
                    get_volar_config(),
                },
            },
        },
    },
}
