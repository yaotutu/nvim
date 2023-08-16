local M = {}


M.setup = function()
  require("lspconfig").emmet_language_server.setup({
    filetypes = { "javascriptreact", "typescriptreact", "vue" },
  })
end

return M
