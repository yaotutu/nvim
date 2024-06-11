local M = {}

M.setup = function()
  require("lspconfig").bashls.setup({})
end

return M
