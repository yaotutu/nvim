local tools = require("util")
return {
  "mrjones2014/legendary.nvim",
  priority = 10000,
  lazy = false,
  config = function()
    require("legendary").setup({
      funcs = {
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
      },
      keymaps = {
        {
          -- create a keymap for the function above
          "<leader>fc",
          tools.CopilotExplainSelectedCode,
          mode = { 'n', 'v' },
          description = "Explain selected code",
        },
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
        { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>",     desc = "CopilotChat - Debug Info" },
        -- Fix the issue with diagnostic
        { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
        -- Clear buffer and chat history
        { "<leader>al", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Clear buffer and chat history" },
        -- Toggle Copilot Chat Vsplit
        { "<leader>av", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle" },
      },
      -- load extensions
      extensions = {
        -- automatically load keymaps from lazy.nvim's `keys` option
        lazy_nvim = true,
        -- load keymaps and commands from nvim-tree.lua
        nvim_tree = true,
        -- load commands from smart-splits.nvim
        -- and create keymaps, see :h legendary-extensions-smart-splits.nvim
        -- load commands from op.nvim
        op_nvim = true,
        -- load keymaps from diffview.nvim
        diffview = true,
      },
    })
  end,
}
