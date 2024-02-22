local M = {}

M.setup = function()
  require("lspconfig").biome.setup({})
end

return M
