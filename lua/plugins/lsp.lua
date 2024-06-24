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
      require("plugins.lsp.html").setup()
      require("plugins.lsp.biome").setup()
      require("plugins.lsp.cssls").setup()
      require("plugins.lsp.emmet").setup()
      require("plugins.lsp.eslint").setup()
      require("plugins.lsp.jsonls").setup()
      require("plugins.lsp.lua-ls").setup()
      require("plugins.lsp.marksman").setup()
      require("plugins.lsp.tailwindcss").setup()
      require("plugins.lsp.typos").setup()
      require("plugins.lsp.prisma").setup()
      require("plugins.lsp.bashls").setup()
      -- require("plugins.lsp.tsserver").setup()
      require("plugins.lsp.volar").setup()
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          tsserver_plugins = {
            "@vue/typescript-plugin",
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      })
    end,
  },
}
