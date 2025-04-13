-- typescript

-- local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
-- local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

return {
    filetypes = { "typescript", "javascript", "vue" },
    init_options = {
        preferences = {
            includeinlayparameternamehints = "all",
            includeinlayparameternamehintswhenargumentmatchesname = true,
            includeinlayfunctionparametertypehints = true,
            includeinlayvariabletypehints = true,
            includeinlaypropertydeclarationtypehints = true,
            includeinlayfunctionlikereturntypehints = true,
            includeinlayenummembervaluehints = true,
            importmodulespecifierpreference = "non-relative",
        },
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                    .. "/node_modules/@vue/language-server",
                languages = { "vue" },
            },
        },
    },
}
