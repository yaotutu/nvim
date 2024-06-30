require("config.basic")
require("config.keymaps")
require("config.autocmds")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")



-- Define the table containing window names to scroll
local windows_to_scroll = {
  "[dap-repl]",
  "DAP Console",
  "DAP Breakpoints",
}

-- Function to scroll specific windows to bottom
local function scroll_windows_to_bottom()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    for _, target_name in ipairs(windows_to_scroll) do
      if bufname:find(target_name, 1, true) then
        vim.api.nvim_win_set_cursor(win, {vim.api.nvim_buf_line_count(bufnr), 0})
      end
    end
  end
end

-- Define a timer to execute scroll_windows_to_bottom every second
local timer = vim.loop.new_timer()
vim.loop.timer_start(timer, 1000, 1000, vim.schedule_wrap(scroll_windows_to_bottom))

