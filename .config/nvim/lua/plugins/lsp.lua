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
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
          },
        },
      })
      require("lspconfig").tsserver.setup({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
      })
      require("lspconfig").tailwindcss.setup({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      })
      require("lspconfig").cssls.setup({})
      require("lspconfig").volar.setup({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        init_options = {
          takeOverMode = {
            module = "js",
            filetypes = { "vue" },
          },
        },
      })
      require("lspconfig").emmet_language_server.setup({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      })
      require("lspconfig").marksman.setup({})

      -- require 'lspconfig'.unocss.setup {}
      local cwd = vim.fn.getcwd()
      local util = require("lspconfig.util")
      local project_root = util.find_node_modules_ancestor(cwd)

      local vue_path = util.path.join(project_root, "node_modules", "vue")
      local is_vue = vim.fn.isdirectory(vue_path) == 1
      if is_vue then
        require("lspconfig").volar.setup({
          filetypes = {
            "vue",
            "javascript",
            "javascript.jsx",
            "typescript",
            "typescript.tsx",
            "javascriptreact",
            "typescriptreact",
            "json",
          },
        })
        require("lspconfig").tsserver.setup({
          autostart = false,
          root_dir = function()
            return false
          end,
          single_file_support = false,
        })
      end
    end,
  },
}
