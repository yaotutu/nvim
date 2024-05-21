return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "eslint",
          "cssls",
          "emmet_ls",
          "volar",
          "marksman",
          "tailwindcss",
          "typos_lsp",
          "biome",
          "tsserver",
          "jsonls",
          "eslint",
        },
      })
    end,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    config = function()
      require("ts-error-translator").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
          require("fidget").setup({
            -- options
          })
        end,
      },
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = {
          source = true,
        },
        float = {
          source = true,
        },
      })
      -- 通用配置
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("lua.plugins.lsp.html").setup()
      require("lua.plugins.lsp.biome").setup()
      require("lua.plugins.lsp.cssls").setup()
      require("lua.plugins.lsp.emmet").setup()
      require("lua.plugins.lsp.eslint").setup()
      require("lua.plugins.lsp.jsonls").setup()
      require("lua.plugins.lsp.lua-ls").setup()
      require("lua.plugins.lsp.marksman").setup()
      require("lua.plugins.lsp.tailwindcss").setup()
      require("lua.plugins.lsp.typos").setup()
    
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
