local tools = require("util")

-- DAP 相关的键映射
local dap_keymaps = {
  {
    "<F5>",
    function()
      require("dap").continue()
    end,
    description = "Continue",
  },
  {
    "<F10>",
    function()
      require("dap").step_over()
    end,
    description = "Step over",
  },
  {
    "<F11>",
    function()
      require("dap").step_into()
    end,
    description = "Step into",
  },
  {
    "<F12>",
    function()
      require("dap").step_out()
    end,
    description = "Step out",
  },
  {
    "<Leader>b",
    function()
      require("dap").toggle_breakpoint()
    end,
    description = "Toggle breakpoint",
  },
  {
    "<Leader>B",
    function()
      require("dap").set_breakpoint()
    end,
    description = "Set breakpoint",
  },
  {
    "<Leader>lp",
    function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end,
    description = "Log point",
  },
  {
    "<Leader>dr",
    function()
      require("dap").repl.open()
    end,
    description = "Open REPL",
  },
  {
    "<Leader>dl",
    function()
      require("dap").run_last()
    end,
    description = "Run last",
  },
  {
    "<Leader>dh",
    function()
      require("dap.ui.widgets").hover()
    end,
    description = "Hover",
  },
  {
    "<Leader>dp",
    function()
      require("dap.ui.widgets").preview()
    end,
    description = "Preview",
  },
  {
    "<Leader>df",
    function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end,
    description = "Show frames",
  },
  {
    "<Leader>ds",
    function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end,
    description = "Show scopes",
  },
  {
    "<Leader>dq",
    function()
      require("dapui").close()
    end,
    description = "Close DAP UI",
  },
}

-- noice 相关的键映射
local noice_keymaps = {
  {
    "<leader>nl",
    function()
      require("noice").cmd("last")
    end,
    description = "Noice - Last",
  },
  {
    "<leader>nd",
    function()
      require("noice").cmd("dismiss")
    end,
    description = "Noice - Dismiss",
  },
  {
    "<leader>nh",
    function()
      require("noice").cmd("history")
    end,
    description = "Noice - History",
  },
  {
    "<leader>nt",
    function()
      require("noice").cmd("telescope")
    end,
    description = "Noice - Telescope",
  },
}

-- spectre 相关的键映射
local spectre_keymaps = {
  { "<leader>fa", '<cmd>lua require("spectre").toggle()<CR>', description = "Toggle Spectre" },
  {
    "<leader>sw",
    '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    description = "Search current word",
  },
  {
    "<leader>fn",
    '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
    description = "Search on current file",
  },
  {
    "<leader>sw",
    '<esc><cmd>lua require("spectre").open_visual()<CR>',
    mode = { "v" },
    description = "Search current word (visual)",
  },
}

-- telescope 相关的键映射
local telescope_keymaps = {
  { "<leader>fb", "<cmd>Telescope buffers<cr>", description = "Telescope - Buffers" },
  {
    "<leader>fs",
    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    description = "Telescope - Current buffer fuzzy find",
  },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", description = "Telescope - Find files" },
  { "<leader>fF", "<cmd>Telescope find_files cwd=~<cr>", description = "Telescope - Find files (no cwd)" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", description = "Telescope - Old files" },
  {
    "<leader>fR",
    "<cmd>Telescope oldfiles cwd=" .. vim.loop.cwd() .. "<cr>",
    description = "Telescope - Old files (current cwd)",
  },
  { "<leader>fp", "<cmd>Telescope projects<cr>", description = "Telescope - Projects" },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", description = "Telescope - Git commits" },
  { "<leader>gs", "<cmd>Telescope git_status<cr>", description = "Telescope - Git status" },
  { "<leader>fu", "<cmd>Telescope undo_tree<cr>", description = "Telescope - Undo tree" },
  { "<leader>ft", "<cmd>TodoTelescope <cr>", description = "Telescope - Undo tree" },
}

local sniprun_keymaps = {
  {
    mode = "v",
    "r",
    "<Plug>SnipRun",
    { silent = true },
    desc = "SnipRun in visual mode",
  },
  {
    mode = "n",
    "<leader>rx",
    "<Plug>SnipClose",
    { silent = true },
    desc = "Close SnipRun",
  },
  {
    mode = "n",
    "<leader>r",
    "ggVG<leader><Plug>SnipRun",
    { noremap = true },
    desc = "SnipRun on whole buffer",
  },
}

local generic_keymaps = {
  {
    -- create a keymap for the function above
    "<leader>fc",
    tools.CopilotExplainSelectedCode,
    mode = { "n", "v" },
    description = "Explain selected code",
  },
}

local copilot_chat_keymaps = {
  {
    "<leader>aq",
    function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
    end,
    desc = "CopilotChat - Quick chat",
  },
  {
    "<leader>am",
    "<cmd>CopilotChatCommit<cr>",
    desc = "CopilotChat - Generate commit message for all changes",
  },
  {
    "<leader>aM",
    "<cmd>CopilotChatCommitStaged<cr>",
    desc = "CopilotChat - Generate commit message for staged changes",
  },
  -- Debug
  { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
  -- Fix the issue with diagnostic
  { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
  -- Clear buffer and chat history
  { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
  -- Toggle Copilot Chat Vsplit
  { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
}

local keymaps = {
  {
    itemgroup = "SnipRun",
    description = "SnipRun Keymaps",
    icon = "",
    keymaps = sniprun_keymaps,
  },
  {
    itemgroup = "CopilotChat",
    description = "CopilotChat Keymaps",
    icon = "",
    keymaps = copilot_chat_keymaps,
  },
  -- Define a generic itemgroup for keymaps without a specific itemgroup
  {
    itemgroup = "Generic",
    description = "General Keymaps",
    icon = "",
    keymaps = generic_keymaps,
  },
  -- DAP
  {
    itemgroup = "DAP",
    description = "DAP Keymaps",
    icon = "",
    keymaps = dap_keymaps,
  },
  {
    itemgroup = "noice",
    description = "Noice Keymaps",
    keymaps = noice_keymaps,
  },
  {
    itemgroup = "spectre",
    description = "Spectre Keymaps",
    keymaps = spectre_keymaps,
  },
  {
    itemgroup = "telescope",
    description = "Telescope Keymaps",
    keymaps = telescope_keymaps,
  },
}

return keymaps
