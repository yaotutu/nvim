local M = {}

M.setup = function()
  require("lspconfig").typos_lsp.setup({})
end

return M
