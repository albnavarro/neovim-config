local M = {}

local providers = { "lsp", "snippets", "buffer" }
local numberOfProviders = #providers
local currentProviderIndex = 1

-- Get next provider
M.next = function()
    currentProviderIndex = currentProviderIndex < numberOfProviders and currentProviderIndex + 1 or 1
    return providers[currentProviderIndex]
end

-- Reset currentProviderIndex
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    callback = function()
        currentProviderIndex = 1
    end,
})

return M
