local M = {}

M.setup = function()
  local checkDependencyInPackageJson = require("util.tools").checkDependencyInPackageJson
  -- print(checkDependencyInPackageJson("biome"))
  if checkDependencyInPackageJson("@biomejs/biome") then
    require("lspconfig").biome.setup({})
  end
end

return M
