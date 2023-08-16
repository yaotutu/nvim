local M = {}

local cwd = vim.fn.getcwd()
local util = require("lspconfig.util")
local project_root = util.find_node_modules_ancestor(cwd)

local vue_path = util.path.join(project_root, "node_modules", "vue")
local is_vue = vim.fn.isdirectory(vue_path) == 1

M.setup = function()
    if is_vue then
        -- vue中禁用tsserver,由volar提供
        require("lspconfig").tsserver.setup({
            autostart = false,
            root_dir = function()
                return false
            end,
            single_file_support = false,
        })
    else
        require("lspconfig").tsserver.setup({
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        })
    end
end

return M
