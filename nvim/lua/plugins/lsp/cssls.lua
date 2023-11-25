local M = {}

M.setup = function()
    require("lspconfig").cssls.setup({})
end

return M
