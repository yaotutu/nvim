-- local notify = require('notify')
local M = {}

-- Check if a file exists
-- @param path (string) The file path
-- @return (boolean) true if the file exists, false otherwise
local function fileExists(path)
  local file = io.open(path, "r")
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
  return vim.fn.fnamemodify(currentFile, ":p:h")
end

-- Detect the package manager used in the current project
-- @return (table) An array containing the package managers used in the current project
function M.detectPackageManager()
  local currentDirectory = getCurrentDirectory()

  -- Check for package-lock.json file
  local packageLockPath = currentDirectory .. "/package-lock.json"
  local hasPackageLock = fileExists(packageLockPath)

  -- Check for yarn.lock file
  local yarnLockPath = currentDirectory .. "/yarn.lock"
  local hasYarnLock = fileExists(yarnLockPath)

  -- Check for pnpm-lock.yaml file
  local pnpmLockPath = currentDirectory .. "/pnpm-lock.yaml"
  local hasPnpmLock = fileExists(pnpmLockPath)

  -- Determine the current environment
  local packageManagers = {}
  if hasPackageLock then
    table.insert(packageManagers, "npm")
  end
  if hasYarnLock then
    table.insert(packageManagers, "yarn")
  end
  if hasPnpmLock then
    table.insert(packageManagers, "pnpm")
  end

  return packageManagers
end

-- Detect the project type of the current project
-- @return (string or nil) The type of the current project, possible values are 'react', 'vue', 'nestjs', 'flutter', or "" if it cannot be determined
function M.detectProjectType()
  local currentDirectory = getCurrentDirectory()

  -- Look for package.json file in the root directory
  local rootDirectory = currentDirectory
  while rootDirectory ~= "/" do
    local packageJsonPath = rootDirectory .. "/package.json"
    local packageJsonFile = io.open(packageJsonPath, "r")
    if packageJsonFile then
      packageJsonFile:close()

      -- Read the content of package.json
      local packageJson = vim.fn.json_decode(vim.fn.readfile(packageJsonPath))

      -- Determine the project type
      if packageJson.dependencies and packageJson.dependencies.react then
        return "react"
      elseif packageJson.dependencies and packageJson.dependencies.vue then
        return "vue"
      elseif packageJson.dependencies and packageJson.dependencies.nestjs then
        return "nestjs"
      elseif packageJson.dependencies and packageJson.dependencies["@biomejs/biome"] then
        return "biome"
      end
      return ""
    end

    rootDirectory = vim.fn.fnamemodify(rootDirectory, ":h")
  end

  -- Look for pubspec.yaml file in the root directory
  local pubspecYamlPath = currentDirectory .. "/pubspec.yaml"
  local hasPubspec = fileExists(pubspecYamlPath)
  if hasPubspec then
    -- Determine the project type
    local pubspecYamlContent = vim.fn.readfile(pubspecYamlPath)
    if vim.fn.matchstr(pubspecYamlContent, "flutter:") ~= -1 then
      return "flutter"
    end
  end

  return nil
end

-- 检查指定依赖是否存在
local function checkDependency(packageJson, dependency)
  if packageJson.dependencies and packageJson.dependencies[dependency] then
    return true
  end
  if packageJson.devDependencies and packageJson.devDependencies[dependency] then
    return true
  end
  return false
end

-- 获取 package.json 的内容
local function getPackageJson()
  local currentDirectory = getCurrentDirectory()

  -- Look for package.json file in the root directory
  local rootDirectory = currentDirectory
  while rootDirectory ~= "/" do
    local packageJsonPath = rootDirectory .. "/package.json"
    local packageJsonFile = io.open(packageJsonPath, "r")
    if packageJsonFile then
      packageJsonFile:close()

      -- Read the content of package.json
      local packageJson = vim.fn.json_decode(vim.fn.readfile(packageJsonPath))

      return packageJson
    end

    rootDirectory = vim.fn.fnamemodify(rootDirectory, ":h")
  end

  return nil
end

-- 判断指定依赖是否存在于 package.json 文件中
function M.checkDependencyInPackageJson(dependency)
  local packageJson = getPackageJson()
  if packageJson then
    return checkDependency(packageJson, dependency)
  end

  return false
end

-- 切换 Copilot 状态
-- 定义全局变量来记录 Copilot 的状态
vim.g.my_copilot_enabled = true

-- 定义触发关闭和启用 Copilot 的函数
function M.toggle_copilot()
  -- 获取当前 Copilot 功能的状态
  local is_enabled = vim.g.my_copilot_enabled

  if is_enabled then
    -- 执行 Copilot disable 命令来关闭功能
    local success, _ = pcall(vim.cmd, "Copilot disable")
    if success then
      -- 发送通知
      vim.notify("已关闭", "info", { title = "Copilot" })
      -- 更新 Copilot 的状态为关闭
      vim.g.my_copilot_enabled = false

      -- 在 30 秒后调用 enable_copilot() 函数启用 Copilot
      vim.defer_fn(function()
        M.toggle_copilot()
      end, 30000)
    else
      -- 发送错误通知
      vim.notify("关闭 Copilot 失败", "error", { title = "Copilot" })
    end
  else
    -- 执行 Copilot enable 命令来启用功能
    local success, _ = pcall(vim.cmd, "Copilot enable")
    if success then
      -- 发送通知
      vim.notify("已开启", "info", { title = "Copilot" })
      -- 更新 Copilot 的状态为开启
      vim.g.my_copilot_enabled = true
    else
      -- 发送错误通知
      vim.notify("启用 Copilot 失败", "error", { title = "Copilot" })
    end
  end
end

-- 关闭所有浮动窗口
function M.close_all_float_windows()
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win_id).relative ~= "" then
      vim.api.nvim_win_close(win_id, true)
    end
  end
end

-- 保存并格式化文件

function M.save_and_format()
  local bufnr = vim.api.nvim_get_current_buf() -- 获取当前缓冲区
  local filetype = vim.bo[bufnr].filetype -- 获取文件类型

  -- 检查文件是否有未保存的更改
  if vim.bo[bufnr].modified then
    -- 保存文件
    vim.cmd("write")
  end

  -- 执行格式化
  -- require("conform").format({
  --   async = true,
  --   lsp_fallback = true,
  -- }, function(formatted_by)
  --   -- 格式化完成后，发送通知
  --   vim.notify("格式化完成", "info", { title = "Conform" })
  --
  --   -- 检查文件类型
  --   if filetype == "typescript" or filetype == "typescriptreact" then
  --     -- 如果是 TypeScript 或 TSX，执行额外的命令
  --     vim.cmd("echo '执行 TypeScript 特定命令'")
  --     vim.cmd("TSToolsAddMissingImports")
  --     -- 在这里添加其他特定命令
  --   end
  --
  --   if formatted_by == "lsp" then
  --     vim.notify(
  --       "使用了 LSP 格式化，因为没有其他格式化工具可用",
  --       "warn",
  --       { title = "Conform - LSP Fallback" }
  --     )
  --   end
  -- end)
  require("conform").format({
    async = true,
    lsp_fallback = true,
  }, function(err, did_edit)
    if err then
      vim.notify("格式化失败: "..err, "error", { title = "Conform" })
    else
      -- 格式化完成后的通知
      -- vim.notify("格式化完成", "info", { title = "Conform" })

      -- 检查是否将使用 LSP 作为格式化的回退
      local options = {} -- 根据需要设置 options
      if require("conform").will_fallback_lsp(options) then
        vim.notify(
          "使用了 LSP 作为格式化工具，因为没有其他工具可用",
          "warn",
          { title = "Conform - LSP Fallback" }
        )
      end
      -- 检查文件类型并执行相应命令
      if filetype == "typescript" or filetype == "typescriptreact" then
        vim.cmd("echo '执行 TypeScript 特定命令'")
        vim.cmd("TSToolsAddMissingImports")
        vim.cmd("TSToolsRemoveUnused")
        -- 在这里添加其他特定命令
      end
    end
  end)
end

-- 封装命令执行函数
function M.execute_command(selected_command)
  if type(selected_command) == "string" and selected_command ~= "" then
    local status, err = pcall(vim.cmd, selected_command)
    if not status then
      vim.notify("Error executing command: " .. err, vim.log.levels.ERROR)
    end
  else
    vim.notify("Invalid command", vim.log.levels.ERROR)
  end
end

-- 确保有多个窗口时再关闭
function M.safe_close_window()
  if vim.fn.winnr("$") > 1 then -- 确保有多个窗口
    vim.cmd("q") -- 关闭当前窗口
  else
    vim.notify("Cannot close last window", vim.log.levels.WARN)
  end
end

-- 安全退出插入模式
function M.safe_exit_insert_mode()
  local current_mode = vim.api.nvim_get_mode().mode -- 获取当前模式
  if current_mode == "i" then -- 检查当前模式是否是插入模式
    vim.cmd("stopinsert") -- 退出插入模式
    vim.notify("Exited insert mode safely", vim.log.levels.INFO) -- 通知用户
  else
    vim.notify("Not in insert mode", vim.log.levels.INFO) -- 如果不是插入模式，通知用户
  end
end

--  安全关闭 Telescope
function M.safe_close_telescope(prompt_bufnr)
  if vim.api.nvim_buf_is_valid(prompt_bufnr) then -- 检查缓冲区是否有效
    local success, err = pcall(function()
      local actions = require("telescope.actions")
      actions.close(prompt_bufnr) -- 尝试关闭 `Telescope`
    end)
    if not success then
      vim.notify("Error closing Telescope: " .. err, vim.log.levels.ERROR)
    end
  else
    vim.notify("Buffer is no longer valid; Telescope might have closed", vim.log.levels.WARN)
  end
end

-- 搜索并执行命令
function M.search_and_execute_commands()
  require("telescope.builtin").commands({
    prompt_title = "Search Neovim Commands",
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selected_command = require("telescope.actions.state").get_selected_entry().name

        if selected_command then
          local status, err = pcall(vim.cmd, selected_command)
          if not status then
            vim.notify("Error executing command: " .. err, vim.log.levels.ERROR)
          end
        end
        M.safe_close_telescope(prompt_bufnr) -- 使用 `M.safe_close`
        M.safe_exit_insert_mode()
      end)
      map("n", "<CR>", function(prompt_bufnr)
        local selected_command = require("telescope.actions.state").get_selected_entry().name
        if selected_command then
          local status, err = pcall(vim.cmd, selected_command)
          if not status then
            vim.notify("Error executing command: " .. err, vim.log.levels.ERROR)
          end
        end
        M.safe_close_telescope(prompt_bufnr) -- 使用 `M.safe_close`
        M.safe_exit_insert_mode()
      end)
      return true -- 允许自定义按键映射
    end,
    -- 过滤器，确保只检索以 "TS" 开头的命令
    sorter = require("telescope.sorters").get_generic_fuzzy_sorter(), -- 使用默认排序
    find_command = function(command_list) -- 自定义命令过滤
      local filtered_commands = {}
      for _, cmd in ipairs(command_list) do
        if cmd:sub(1, 2) == "TS" then -- 只保留以 "TS" 开头的命令
          table.insert(filtered_commands, cmd)
        end
      end
      return filtered_commands
    end,
  })
end

M.root_patterns = { ".git", "lua" }

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace
          and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      opts.attach_mappings = function(_, map)
        map("i", "<a-c>", function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          M.telescope(
            params.builtin,
            vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end
end

return M
