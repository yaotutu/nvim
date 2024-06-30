-- lua/plugins/dap/dap-ui.lua
local dap, dapui = require("dap"), require("dapui")
require("nvim-dap-virtual-text").setup()

dapui.setup({
  floating = {
    border = "double",
    mappings = {
      close = { "q", "<Esc>" }
    }
  },
  layouts = { {
    elements = { {
      id = "repl",
      size = 0.6
    }, {
      id = "console",
      size = 0.2
    }, {
      id = "breakpoints",
      size = 0.2
    } },
    position = "bottom",
    size = 5
  } },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.after.event_terminated['restart'] = function(session, body)
  dap.run(session.config)
end

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

vim.fn.sign_define("DapBreakpoint",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition",
  { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })


