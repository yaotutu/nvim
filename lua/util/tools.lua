local M = {}

-- Check if a file exists
-- @param path (string) The file path
-- @return (boolean) true if the file exists, false otherwise
local function fileExists(path)
  local file = io.open(path, 'r')
  if file then
    file:close()
    return true
  end
  return false
end

-- Get the current directory of the file
-- @return (string) The path of the current file's directory
local function getCurrentDirectory()
  local currentBuffer = vim.api.nvim_get_current_buf()
  local currentFile = vim.api.nvim_buf_get_name(currentBuffer)
  return vim.fn.fnamemodify(currentFile, ':p:h')
end

-- Detect the package manager used in the current project
-- @return (table) An array containing the package managers used in the current project
function M.detectPackageManager()
  local currentDirectory = getCurrentDirectory()

  -- Check for package-lock.json file
  local packageLockPath = currentDirectory .. '/package-lock.json'
  local hasPackageLock = fileExists(packageLockPath)

  -- Check for yarn.lock file
  local yarnLockPath = currentDirectory .. '/yarn.lock'
  local hasYarnLock = fileExists(yarnLockPath)

  -- Check for pnpm-lock.yaml file
  local pnpmLockPath = currentDirectory .. '/pnpm-lock.yaml'
  local hasPnpmLock = fileExists(pnpmLockPath)

  -- Determine the current environment
  local packageManagers = {}
  if hasPackageLock then
    table.insert(packageManagers, 'npm')
  end
  if hasYarnLock then
    table.insert(packageManagers, 'yarn')
  end
  if hasPnpmLock then
    table.insert(packageManagers, 'pnpm')
  end

  return packageManagers
end

-- Detect the project type of the current project
-- @return (string or nil) The type of the current project, possible values are 'react', 'vue', 'nestjs', 'flutter', or nil if it cannot be determined
function M.detectProjectType()
  local currentDirectory = getCurrentDirectory()

  -- Look for package.json file in the root directory
  local rootDirectory = currentDirectory
  while rootDirectory ~= '/' do
    local packageJsonPath = rootDirectory .. '/package.json'
    local packageJsonFile = io.open(packageJsonPath, 'r')
    if packageJsonFile then
      packageJsonFile:close()

      -- Read the content of package.json
      local packageJson = vim.fn.json_decode(vim.fn.readfile(packageJsonPath))

      -- Determine the project type
      if packageJson.dependencies and packageJson.dependencies.react then
        return 'react'
      elseif packageJson.dependencies and packageJson.dependencies.vue then
        return 'vue'
      elseif packageJson.dependencies and packageJson.dependencies.nestjs then
        return 'nestjs'
      end
    end

    rootDirectory = vim.fn.fnamemodify(rootDirectory, ':h')
  end

  -- Look for pubspec.yaml file in the root directory
  local pubspecYamlPath = currentDirectory .. '/pubspec.yaml'
  local hasPubspec = fileExists(pubspecYamlPath)
  if hasPubspec then
    -- Determine the project type
    local pubspecYamlContent = vim.fn.readfile(pubspecYamlPath)
    if vim.fn.matchstr(pubspecYamlContent, 'flutter:') ~= -1 then
      return 'flutter'
    end
  end

  return nil
end

return M

