return {
  "stevearc/conform.nvim",
  enabled = true,
  config = function()
    require("conform").setup({
      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_fallback = true,
        timeout_ms = 500,
      },
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
