-- local Util = require("util")
local Tools = require("util")

-- disable default keymap
vim.api.nvim_set_keymap("n", "q", "<Nop>", { silent = true })

-- 测试函数,用于测试当前文件是否被加载
-- vim.notify("Hello, world!", vim.log.INFO, { title = "Notification", timeout = 3000 })

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = {
  noremap = true,
  silent = true,
}

-- 本地变量
local map = vim.api.nvim_set_keymap

-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_", opt)
map("v", "g_", "$", opt)
map("n", "$", "g_", opt)
map("n", "g_", "$", opt)

-- 命令行下 Ctrl+j/k  上一个下一个
map("c", "<C-j>", "<C-n>", { noremap = false })
map("c", "<C-k>", "<C-p>", { noremap = false })

-- fix :set wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 上下滚动浏览
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)
map("v", "<C-j>", "5j", opt)
map("v", "<C-k>", "5k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "10k", opt)
map("n", "<C-d>", "10j", opt)

-- magic search
map("n", "/", "/\\v", { noremap = true, silent = false })
map("v", "/", "/\\v", { noremap = true, silent = false })

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
-- map("n", "qq", ":q!<CR>", opt)
map("n", "<leader>q", ":qa!<CR>", opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)


------------------------------------------------------------------
-- windows 分屏快捷键
------------------------------------------------------------------
-- 取消 s 默认功能
-- map("n", "s", "", opt)
map("n", "<leader>w-", ":vsp<CR>", opt)
map("n", "<leader>w_", ":sp<CR>", opt)
-- 关闭当前
map("n", "<leader>wc", "<C-w>c", opt)
map("n", "<leader>wf", "<Cmd>lua require('util.tools').close_all_float_windows() <CR>", opt)

-- 关闭其他
map("n", "<leader>wo", "<C-w>o", opt) -- close others
-- alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- 左右比例控制
map("n", "<leader>wh", ":vertical resize -2<CR>", opt)
map("n", "<leader>wl", ":vertical resize +2<CR>", opt)
map("n", "<leader>wH", ":vertical resize -10<CR>", opt)
map("n", "<leader>wL", ":vertical resize +10<CR>", opt)
-- 上下比例
map("n", "<leader>wk", ":resize +2<CR>", opt)
map("n", "<leader>wj", ":resize -2<CR>", opt)
map("n", "<leader>wK", ":resize +10<CR>", opt)
map("n", "<leader>wJ", ":resize -10<CR>", opt)
-- 相等比例
map("n", "<leader>w=", "<C-w>=", opt)
-- 切换窗口
map("n", "<leader>ww", "<cmd>lua require('nvim-window').pick()<cr>", opt)
-- 水平分割终端
map("n", "<Leader>t-", ":ToggleTerm direction=vertical<CR>", opt)
-- 垂直分割终端
map("n", "<Leader>tt", ":ToggleTerm 1  direction=horizontal<CR>", opt)
map("n", "<Leader>t1", ":ToggleTerm  1 <CR> ", opt)
map("n", "<Leader>t2", ":ToggleTerm  2 <CR>", opt)
map("n", "<Leader>t3", ":ToggleTerm  3 <CR>", opt)
map("n", "<Leader>t4", ":ToggleTerm  4 <CR>", opt)
map("n", "<leader>tf", ":ToggleTerm 9 direction=float<CR>", opt)
-- 退出终端inert mode
map("t", ",,", "<C-\\><C-n>", opt)
-- save file
map("i", "<C-s>", "<cmd>w<cr><esc>", opt)
map("v", "<C-s>", "<cmd>w<cr><esc>", opt)
map("n", "<C-s>", "<cmd>w<cr><esc>", opt)
map("s", "<C-s>", "<cmd>w<cr><esc>", opt)

--System clipboard
map("v", "<leader>y", [["+y]], opt)
map("n", "<leader>y", [["+y]], opt)
map("n", "<leader>Y", [["+Y]], opt)
map("v", "<leader>p", [["+p]], opt)
map("n", "<leader>p", [["+p]], opt)
map("n", "<leader>P", [["+P]], opt)

--------------------------------------------------------------------
-- treesitter 折叠
map("n", "zz", ":foldclose<CR>", opt)
map("n", "Z", ":foldopen<CR>", opt)

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opt)
-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- "moll/vim-bbye" 关闭当前 buffer
map("n", "<leader>bc", ":Bdelete!<CR>", opt)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)
-- 关闭选中标签页
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opt)

-- 选中全部文本
map("n", "<leader>as", "ggVG", opt)
-- 复制全部数据到系统剪切板
map("n", "<leader>ay", 'ggVG"+y', opt)

-- 将当前 buffer 清空，并将系统剪切板的数据粘贴上去
map("n", "<leader>ap", 'ggVGd"+P', opt)

-- lsp 快捷键设置

vim.keymap.set("n", "go", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "gl", vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- Buffer local mappings.
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      Tools.save_and_format()
    end, opts)
    vim.keymap.set("n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
    vim.keymap.set("n", "<space>gd", vim.lsp.buf.definition, { noremap = true })
    vim.keymap.set("n", "gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { noremap = true })
  end,
})




vim.keymap.set({ "n", "v", "o" }, "<leader>jj", "<cmd>Legendary<CR>", opt)
