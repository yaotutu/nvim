local Util = require("util")

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

map("n", "<leader>w", ":w<CR>", opt)
map("n", "<leader>wq", ":wqa!<CR>", opt)

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
map("n", "qq", ":q!<CR>", opt)
map("n", "<leader>q", ":qa!<CR>", opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)

------------------------------------------------------------------
-- windows 分屏快捷键
------------------------------------------------------------------
-- 取消 s 默认功能
-- map("n", "s", "", opt)
map("n", "<leader>s-", ":vsp<CR>", opt)
map("n", "<leader>s_", ":sp<CR>", opt)
-- 关闭当前
map("n", "<leader>sc", "<C-w>c", opt)
-- 关闭其他
map("n", "<leader>so", "<C-w>o", opt) -- close others
-- alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)


-- 左右比例控制
map("n", "<leader>sh", ":vertical resize -2<CR>", opt)
map("n", "<leader>sl", ":vertical resize +2<CR>", opt)
map("n", "<leader>sH", ":vertical resize -10<CR>", opt)
map("n", "<leader>sL", ":vertical resize +10<CR>", opt)
-- 上下比例
map("n", "<leader>sk", ":resize +2<CR>", opt)
map("n", "<leader>sj", ":resize -2<CR>", opt)
map("n", "<leader>sK", ":resize +10<CR>", opt)
map("n", "<leader>sJ", ":resize -10<CR>", opt)
-- 相等比例
map("n", "<leader>s=", "<C-w>=", opt)
-- 水平分割终端
map("n", "<Leader>t-", ":ToggleTerm direction=vertical<CR>", opt)
-- 垂直分割终端
map("n", "<Leader>t_", ":ToggleTerm direction=horizontal<CR>", opt)
map("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opt)
-- 退出终端
map('t', ',,', '<C-\\><C-n>', opt)
-- save file
map("i", "<C-s>", "<cmd>w<cr><esc>", opt)
map("v", "<C-s>", "<cmd>w<cr><esc>", opt)
map("n", "<C-s>", "<cmd>w<cr><esc>", opt)
map("s", "<C-s>", "<cmd>w<cr><esc>", opt)

--------------------------------------------------------------------
-- 插件快捷键
local pluginKeys = {}
-- lazygit
map("n", '<leader>gg', ':LazyGit<CR>', opt)
-- treesitter 折叠
map("n", "zz", ":foldclose<CR>", opt)
map("n", "Z", ":foldopen<CR>", opt)

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

-- ctrl + /
map("n", "<C-_>", "gcc", { noremap = false })
map("v", "<C-_>", "gcc", { noremap = false })

-- lsp 快捷键设置
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
vim.keymap.set("n", "<leader>nl", function()
    require("noice").cmd("last")
end)
vim.keymap.set("n", "<leader>nl", function()
    require("noice").cmd("dismiss")
end)
vim.keymap.set("n", "<leader>nh", function()
    require("noice").cmd("history")
end)
vim.keymap.set("n", "<leader>nt", function()
    require("noice").cmd("telescope")
end)

-- SnipRun
vim.api.nvim_set_keymap('v', 'r', '<Plug>SnipRun', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rx', '<Plug>SnipClose', { silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", "ggVG<leader><Plug>SnipRun", { noremap = true })

-- trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)

-- spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})

-- telescope
-- vim.keymap.set('n', '<leader>ff', "<cmd>Telescope live_grep<cr>", opt)
vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<cr>", opt)
vim.keymap.set('n', '<leader>ff', Util.telescope("files"), opt)
vim.keymap.set('n', '<leader>fF', Util.telescope("files", { cwd = false }), opt)
vim.keymap.set('n', '<leader>fr', "<cmd>Telescope oldfiles<cr>", opt)
vim.keymap.set('n', '<leader>fR', Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), opt)
-- git
vim.keymap.set('n', '<leader>gc', "<cmd>Telescope git_commits<cr>", opt)
vim.keymap.set('n', '<leader>gs', "<cmd>Telescope git_status<cr>", opt)



return pluginKeys
