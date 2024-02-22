return {
  "mfussenegger/nvim-lint",
  enabled = false,
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "eslint" },
      typescript = { "biomejs", "eslint" },
      typescriptreact = { "eslint" },
      javascriptreact = { "eslint" },
    }
  end,
}
