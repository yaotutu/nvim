return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "eslint", "cssls", "emmet_ls", "volar", "marksman", "tailwindcss", "typos_lsp" },
      })
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
      -- 通用配置
      require("mason").setup()
      require("mason-lspconfig").setup()
      -- 语言服务器
      require("plugins.lsp.lua-ls").setup()
      -- require("plugins.lsp.tsserver").setup()
      require("plugins.lsp.tailwindcss").setup()
      require("plugins.lsp.cssls").setup()
      require("plugins.lsp.emmet").setup()
      require("plugins.lsp.marksman").setup()
      require("plugins.lsp.volar").setup()
      require("plugins.lsp.gopls").setup()
    end,
  },
  -- ts config
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local projectType = require("util.tools").detectProjectType()
      if projectType ~= "vue" then
        require("typescript-tools").setup({
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            if vim.lsp.inlay_hint then
              vim.lsp.inlay_hint.enable(bufnr, true)
            end
          end,
          settings = {
            tsserver_file_preferences = {
              -- Inlay Hints
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        })
      end
    end,
  },
}
