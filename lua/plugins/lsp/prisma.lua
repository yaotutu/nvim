local M = {}


M.setup = function()
  require 'lspconfig'.prismals.setup({
    filetypes = { "prisma" },
  })
end

return M
