local gstatus = { ahead = 0, behind = 0 }
local function update_gstatus()
  local Job = require 'plenary.job'
  Job:new({
    command = 'git',
    args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
    on_exit = function(job, _)
      local res = job:result()[1]
      if type(res) ~= 'string' then
        gstatus = { ahead = 0, behind = 0 }; return
      end
      local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
      if not ok then ahead, behind = 0, 0 end
      gstatus = { ahead = ahead, behind = behind }
    end,
  }):start()
end

if _G.Gstatus_timer == nil then
  _G.Gstatus_timer = vim.loop.new_timer()
else
  _G.Gstatus_timer:stop()
end
_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))


return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { 'dokwork/lualine-ex' },
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
  },
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        component_separators = { left = "|", right = "|" },
        -- https://github.com/ryanoasis/powerline-extra-symbols
        section_separators = { left = " ", right = "" },
      },
      extensions = { "nvim-tree", "toggleterm" },
      sections = {
        lualine_b = { 'ex.git.branch', { function()
          return gstatus.ahead .. ' ' .. gstatus.behind ..
              ''
        end }, 'diff', 'diagnostics' },
        lualine_c = {
          {
            "lsp_progress",
            spinner_symbols = { " ", " ", " ", " ", " ", " " },
          }
        },
        lualine_x = {
          "filesize",
          {
            "fileformat",
            -- symbols = {
            --   unix = '', -- e712
            --   dos = '', -- e70f
            --   mac = '', -- e711
            -- },
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
          "encoding",
          "filetype",
        },
        lualine_y = {
          "ex.lsp.single",
        },
        lualine_z = { "ex.cwd" },
      },
    }
  end,
}
