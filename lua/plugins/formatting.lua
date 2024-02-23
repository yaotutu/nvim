return {
  "stevearc/conform.nvim",
  enabled = true,
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "biome", "prettierd", "prettier" } },
        javascriptreact = { { "biome", "prettierd", "prettier" } },
        typescript = { { "biome", "prettierd", "prettier" } },
        typescriptreact = { { "biome", "prettierd", "prettier" } },
      },
    })
  end,
}
