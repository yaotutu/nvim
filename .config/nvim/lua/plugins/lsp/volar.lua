local M = {}

M.setup = function()
  require("lspconfig").volar.setup({
    filetypes = { "typescript", "javascript", "vue", "json" },
  })
end

return M
