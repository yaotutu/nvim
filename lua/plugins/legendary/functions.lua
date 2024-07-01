local tools = require("util")

local functions = {
  {
    function()
      print("Hello World")
    end,
    description = "Print Hello World!",
  },
  {
    tools.CopilotExplainSelectedCode,
    description = "Explain selected code using Copilot",
  },
  {
    function()
      local bufname = vim.fn.bufname('%')
      if bufname ~= '' then
        print("Current buffer name: " .. bufname)
      else
        print("Current buffer is not associated with a file")
      end
    end,
    description = "Print the current buffer name",
  }
}

return functions
