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
          "eslint"
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
}
