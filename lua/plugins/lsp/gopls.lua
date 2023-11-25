local M = {}

M.setup = function()
    require("lspconfig").gopls.setup({})
end

return M
