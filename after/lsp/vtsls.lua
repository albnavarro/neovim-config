-- typescript

-- local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
-- local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

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
                },
            },
            tsserver = {
                globalPlugins = {
                    {
                        name = "@vue/typescript-plugin",
                        -- location = volar_path,
                        location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                            .. "/node_modules/@vue/language-server",
                        languages = { "vue" },
                        configNamespace = "typescript",
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
        },
    },
}
