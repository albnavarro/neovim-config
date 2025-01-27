local M = {}

local providers = { "lsp", "snippets", "buffer" }
local numberOfProviders = #providers
local currentProviderIndex = 1

-- Get next provider
M.getNextProvider = function()
    currentProviderIndex = currentProviderIndex < numberOfProviders and currentProviderIndex + 1 or 1
    return providers[currentProviderIndex]
end

return M
