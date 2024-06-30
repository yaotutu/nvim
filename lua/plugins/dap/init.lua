return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "js-debug-adapter")
      end,
    },
  },
  config = function()
    -- 引入分离的配置文件
    require("plugins.dap.adapters")
    require("plugins.dap.configurations")
    require("plugins.dap.dap-ui")
  end,
}
