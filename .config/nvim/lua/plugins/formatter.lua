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
      on_post_format = function(data)
        -- data包含格式化的文件路径和耗时
        vim.notify("Formatted " .. data.file .. " in " .. data.duration .. " ms")
      end,

      filetype = {
        lua = {
          require("formatter.filetypes.lua").stylua,
        },
        javascript = {
          require("formatter.filetypes.typescript").prettier,
        },
        javascriptreact = {
          require("formatter.filetypes.typescript").prettier,
        },
        typescript = {
          require("formatter.filetypes.typescript").prettier,
        },
        typescriptreact = {
          require("formatter.filetypes.typescript").prettier,
        },
        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      },
    })
  end,
}
