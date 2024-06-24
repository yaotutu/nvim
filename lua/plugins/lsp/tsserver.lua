local M = {}

local cwd = vim.fn.getcwd()
local util = require("lspconfig.util")
local project_root = util.find_node_modules_ancestor(cwd)

local vue_path = util.path.join(project_root, "node_modules", "vue")
local is_vue = vim.fn.isdirectory(vue_path) == 1

local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
  .. "/node_modules/@vue/language-server"
print("vue_language_server_path", vue_language_server_path)

M.setup = function()
  require("lspconfig").tsserver.setup({
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "javascript", "typescript", "vue" },
        },
      },
    },
    filetypes = {
      "javascript",
      "typescript",
      "vue",
    },
  })

  -- You must make sure volar is setup
  -- e.g. require'lspconfig'.volar.setup{}
  -- See volar's section for more information

  -- if is_vue then
  --   -- vue中禁用tsserver,由volar提供
  --   require("lspconfig").tsserver.setup({
  --     autostart = false,
  --     root_dir = function()
  --       return false
  --     end,
  --     single_file_support = false,
  --   })
  -- else
  --   require("lspconfig").tsserver.setup({
  --     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
  --   })
  -- end
end

return M
