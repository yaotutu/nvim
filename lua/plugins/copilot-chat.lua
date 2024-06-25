return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch       = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
  },
  opts         = {
    debug = true, -- Enable debugging
    -- See Configuration section for rest
  },
  -- See Commands section for default commands if you want to lazy load on them
  -- default prompts
  config       = function()
    local select = require("CopilotChat.select")

    require("CopilotChat").setup({

      -- default selection (visual or line)
      selection = function(source)
        return select.visual(source) or select.line(source)
      end,

      -- default prompts
      prompts = {
        Explain = {
          prompt = '/COPILOT_EXPLAIN 请为当前选中的内容写一段解释文本。',
        },
        Review = {
          prompt = '/COPILOT_REVIEW 请审核选中的代码。',
          callback = function(response, source)
            -- 详见 config.lua 的实现
          end,
        },
        Fix = {
          prompt = '/COPILOT_GENERATE 这段代码有问题。请重写代码以修复这个错误。',
        },
        Optimize = {
          prompt = '/COPILOT_GENERATE 优化选中的代码以提高性能和可读性。',
        },
        Docs = {
          prompt = '/COPILOT_GENERATE 请为选中的代码添加文档注释。',
        },
        Tests = {
          prompt = '/COPILOT_GENERATE 请为我的代码生成测试。',
        },
        Commit = {
          prompt = '请为此次更改编写commit信息，遵循commitizen规范。确保标题不超过50个字符，正文在72个字符处换行。将整个消息用gitcommit语言的代码块包裹。请用简体中文实现',
          selection = select.gitdiff,
        },
        -- FixDiagnostic = {
        --   prompt = '请协助解决文件中的以下诊断问题:',
        --   selection = select.diagnostics,
        -- },
        -- Commit = {
        --   prompt = '请为变更写一条符合 commitizen 规范的提交信息。确保标题最多50个字符，信息在72个字符处换行。将整个信息用 gitcommit 语言的代码块包裹。',
        --   selection = select.gitdiff,
        -- },
        -- CommitStaged = {
        --   prompt = '请为变更写一条符合 commitizen 规范的提交信息。确保标题最多50个字符，信息在72个字符处换行。将整个信息用 gitcommit 语言的代码块包裹。',
        --   selection = function(source)
        --     return select.gitdiff(source, true)
        --   end,
        -- },
      },
      window = {
        layout = 'vertical',    -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.4,            -- fractional width of parent, or absolute width in columns when > 1
        height = 0.5,           -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = 'editor',    -- 'editor', 'win', 'cursor', 'mouse'
        border = 'single',      -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = nil,              -- row position of the window, default is centered
        col = nil,              -- column position of the window, default is centered
        title = 'Copilot Chat', -- title of chat window
        footer = nil,           -- footer of chat window
        zindex = 1,             -- determines if window is on top or below other floating windows
      },
      mappings = {
        complete = {
          detail = 'Use @<Tab> or /<Tab> for options.',
          insert = '<Tab>',
        },
        close = {
          normal = 'q',
          insert = '<C-c>'
        },
        -- Reset the chat buffer
        reset = {
          normal = "<C-x>",
          insert = "<C-x>",
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>'
        },
        yank_diff = {
          normal = 'gy',
        },
        show_diff = {
          normal = 'gd'
        },
        show_system_prompt = {
          normal = 'gp'
        },
        show_user_selection = {
          normal = 'gs'
        }
      }
    })
  end
}
