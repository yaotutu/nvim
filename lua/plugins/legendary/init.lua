local functions = require("plugins.legendary.functions")
local keymaps = require("plugins.legendary.keymaps")

return {
  "mrjones2014/legendary.nvim",
  priority = 10000,
  lazy = false,
  config = function()
    require("legendary").setup({
      funcs = functions,
      keymaps = keymaps,
      -- load extensions
      extensions = {
        -- automatically load keymaps from lazy.nvim's `keys` option
        lazy_nvim = true,
        -- load keymaps and commands from nvim-tree.lua
        nvim_tree = true,
        -- load commands from smart-splits.nvim
        -- and create keymaps, see :h legendary-extensions-smart-splits.nvim
        -- load commands from op.nvim
        op_nvim = true,
        -- load keymaps from diffview.nvim
        diffview = true,
      },
    })
  end,
}
