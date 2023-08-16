local M = {}


M.setup = function()
  require("lspconfig").tailwindcss.setup({
    filetypes = { "javascriptreact", "typescriptreact", "vue" },
  })
end

return M
