-- lua/plugins/dap/configurations.lua
local dap = require("dap")
local cwd = vim.fn.getcwd()

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  if not dap.configurations[language] then
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach-Port-9229",
        cwd = cwd .. '/packages/backend',
        port = "9229",
        sourceMaps = true,
      },
    }
  end
end
