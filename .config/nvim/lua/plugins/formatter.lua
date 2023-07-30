return {
  "mhartington/formatter.nvim",
  config = function()
    -- Utilities for creating configurations
    local util = require("formatter.util")

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require("formatter").setup({
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        lua = {
          require("formatter.filetypes.lua").stylua,
        },
        typescript = {
          require("formatter.filetypes.lua").prettier,
        },
        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      },
    })
  end,
}