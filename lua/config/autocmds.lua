-- 获取系统
local os = vim.loop.os_uname().sysname

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- 回到上一次退出时编辑文件的位置
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = augroup("last_loc"),
--   callback = function()
--     local exclude = { "gitcommit" }
--     local buf = vim.api.nvim_get_current_buf()
--     if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
--       return
--     end
--     local mark = vim.api.nvim_buf_get_mark(buf, '"')
--     local lcount = vim.api.nvim_buf_line_count(buf)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "dart",
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", ":FlutterRun<CR>", { noremap = true })
--     vim.api.nvim_buf_set_keymap(0, "n", "<leader>R", ":FlutterRestart<CR>", { noremap = true })
--     vim.api.nvim_buf_set_keymap(0, "n", "<leader>c", "<cmd>Telescope flutter commands<CR>", { noremap = true })
--   end,
-- })
