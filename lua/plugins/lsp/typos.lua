local M = {}

M.setup = function()
  require("lspconfig").typos_lsp.setup({
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern("typos.toml", "_typos.toml", ".typos.toml")(fname)
        or vim.fn.getcwd()
    end,
    init_options = {
      diagnosticSeverity = "Error",
    },
  })
end

return M
