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

      -- 语言服务器
      -- require("plugins.lsp.lua-ls").setup()
      -- require("plugins.lsp.tsserver").setup()
      -- require("plugins.lsp.tailwindcss").setup()
      -- require("plugins.lsp.cssls").setup()
      -- require("plugins.lsp.emmet").setup()
      -- require("plugins.lsp.marksman").setup()
      -- require("plugins.lsp.volar").setup()
      -- require("plugins.lsp.gopls").setup()
      -- require("plugins.lsp.jsonls").setup()
      -- require("lspconfig").biome.setup({})
      -- 获取 Lua 配置文件目录
      local config_dir = vim.fn.stdpath("config")
      -- 构建完整路径
      local lsp_folder = config_dir .. "/lua/plugins/lsp/"
      -- 初始化 lsp_plugins 表
      local lsp_plugins = {}
      -- 扫描 lua/plugins/lsp/ 文件夹
      local function get_files_in_folder()
        local dir = vim.loop.fs_scandir(lsp_folder)
        if dir then
          while true do
            local name, type = vim.loop.fs_scandir_next(dir)
            if not name then
              break
            end
            if type == "file" then
              local plugin_name = name:match("(.*)%.lua$")
              if plugin_name then
                -- 处理找到的文件
                -- print("Found Lua LSP plugin:", plugin_name)
                table.insert(lsp_plugins, plugin_name)
              end
            end
          end
        end
      end
      -- 调用函数进行扫描
      get_files_in_folder()
      -- 循环执行 setup 函数
      for _, plugin in ipairs(lsp_plugins) do
        local lsp_module = string.format("plugins.lsp.%s", plugin)
        require(lsp_module).setup()
      end
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
              vim.lsp.inlay_hint.enable(bufnr, false)
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
