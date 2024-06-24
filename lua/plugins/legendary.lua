return {
  "mrjones2014/legendary.nvim",
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 10000,
  lazy = false,
  -- sqlite is only needed if you want to use frecency sorting
  -- dependencies = { 'kkharji/sqlite.lua' }
  config = function()
    require("legendary").setup({
      funcs = {
        {
          function()
            print("Hello World")
          end,
          description = "Print Hello World!",
        },
      },
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
