local M = {}

M.setup = function()
  local checkDependencyInPackageJson = require("util").checkDependencyInPackageJson
  print(checkDependencyInPackageJson("eslint"))
  if checkDependencyInPackageJson("eslint") then
    require("lspconfig").eslint.setup({})
  end
end

return M
