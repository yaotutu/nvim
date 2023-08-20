return {
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "williamboman/mason.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 通用配置
      require("mason").setup()
      require("mason-lspconfig").setup()
      -- 语言服务器
      require("plugins.lsp.lua-ls").setup()
      require("plugins.lsp.tsserver").setup()
      require("plugins.lsp.tailwindcss").setup()
      require("plugins.lsp.cssls").setup()
      require("plugins.lsp.emmet").setup()
      require("plugins.lsp.marksman").setup()
      require("plugins.lsp.volar").setup()
      require("plugins.lsp.gopls").setup()
    end,
  },
}
