-- 测试函数,用于测试当前文件是否被加载
-- vim.notify("Hello, world!", vim.log.INFO, { title = "Notification", timeout = 3000 })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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
-- map("i", "<C-h>", "<ESC>I", opt)
-- map("i", "<C-l>", "<ESC>A", opt)

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
-- <leader> + hjkl 窗口之间跳转
-- map("n", "<leader>h", "<C-w>h", opt)
-- map("n", "<leader>j", "<C-w>j", opt)
-- map("n", "<leader>k", "<C-w>k", opt)
-- map("n", "<leader>l", "<C-w>l", opt)

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
-- Terminal相关
map("n", "<leader>st", ":sp | terminal<CR>", opt)
map("n", "<leader>stv", ":vsp | terminal<CR>", opt)
-- Esc 回 Normal 模式
-- map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
-- map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)


--------------------------------------------------------------------
-- 插件快捷键
local pluginKeys = {}
-- lazygit
map("n", '<leader>gg', ':LazyGit<CR>', opt)
-- treesitter 折叠
map("n", "zz", ":foldclose<CR>", opt)
map("n", "Z", ":foldopen<CR>", opt)




-- nvim-tree
-- map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
-- map("n", "<leader>m", ":NvimTreeToggle<CR>", opt)
pluginKeys.nvimTreeList = function(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<CR>', api.node.run.system, opts('Run System'))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', 'i', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))

    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    vim.keymap.set('n', 'I', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', 'n', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', ']', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '[', api.tree.change_root_to_parent, opts('Up'))
end

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

-- Telescope
-- map("n", "<leader>ff", ":Telescope find_files<CR>", opt)
-- map("n", "<leader>fg", ":Telescope live_grep<CR>", opt)
-- map("n", "<leader>fb", ":Telescope buffers<CR>", opt)


-- map("n", "<leader>ff", "require('telescope.builtin').find_files", opt)
-- map("n", "<leader>fg", "require('telescope.builtin').live_grep", opt)
-- map("n", "<leader>fb", "require('telescope.builtin').buffers", opt)



-- Telescope 列表中 插入模式快捷键
-- pluginKeys.telescopeList = {
--     i = {
--         -- 上下移动
--         ["<C-j>"] = "move_selection_next",
--         ["<C-k>"] = "move_selection_previous",
--         ["<C-n>"] = "move_selection_next",
--         ["<C-p>"] = "move_selection_previous",
--         -- 历史记录
--         ["<Down>"] = "cycle_history_next",
--         ["<Up>"] = "cycle_history_prev",
--         -- 关闭窗口
--         -- ["<esc>"] = actions.close,
--         ["<C-c>"] = "close",
--         -- 预览窗口上下滚动
--         ["<C-u>"] = "preview_scrolling_up",
--         ["<C-d>"] = "preview_scrolling_down",
--     },
-- }

-- 代码注释插件
-- see ./lua/plugin-config/comment.lua
pluginKeys.comment = {
    -- Normal 模式快捷键
    toggler = {
        line = "gcc",  -- 行注释
        block = "gbc", -- 块注释
    },
    -- Visual 模式
    opleader = {
        line = "gc",
        bock = "gb",
    },
}
-- ctrl + /
map("n", "<C-_>", "gcc", { noremap = false })
map("v", "<C-_>", "gcc", { noremap = false })

-- lsp 快捷键设置
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
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
-- noice
-- :Noice or :Noice history shows the message history
-- :Noice last shows the last message in a popup
-- :Noice dismiss dismiss all visible messages
-- :Noice errors shows the error messages in a split. Last errors on top
-- :Noice disable disables Noice
-- :Noice enable enables Noice
-- :Noice stats shows debugging stats
-- :Noice telescope opens message history in Telescope
vim.keymap.set("n", "<leader>nl", function()
    require("noice").cmd("last")
end)
vim.keymap.set("n", "<leader>nl", function()
    require("noice").cmd("dismiss")
end)
vim.keymap.set("n", "<leader>nh", function()
    require("noice").cmd("history")
end)

-- typescript 快捷键
-- pluginKeys.mapTsLSP = function(mapbuf)
--     mapbuf("n", "gs", ":TSLspOrganize<CR>", opt)
--     mapbuf("n", "gR", ":TSLspRenameFile<CR>", opt)
--     mapbuf("n", "gi", ":TSLspImportAll<CR>", opt)
-- end

-- -- nvim-dap
-- pluginKeys.mapDAP = function()
--     -- 开始
--     map("n", "<leader>dd", ":RustDebuggables<CR>", opt)
--     -- 结束
--     map(
--         "n",
--         "<leader>de",
--         ":lua require'dap'.close()<CR>"
--         .. ":lua require'dap'.terminate()<CR>"
--         .. ":lua require'dap.repl'.close()<CR>"
--         .. ":lua require'dapui'.close()<CR>"
--         .. ":lua require('dap').clear_breakpoints()<CR>"
--         .. "<C-w>o<CR>",
--         opt
--     )
--     -- 继续
--     map("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opt)
--     -- 设置断点
--     map("n", "<leader>dt", ":lua require('dap').toggle_breakpoint()<CR>", opt)
--     map("n", "<leader>dT", ":lua require('dap').clear_breakpoints()<CR>", opt)
--     --  stepOver, stepOut, stepInto
--     map("n", "<leader>dj", ":lua require'dap'.step_over()<CR>", opt)
--     map("n", "<leader>dk", ":lua require'dap'.step_out()<CR>", opt)
--     map("n", "<leader>dl", ":lua require'dap'.step_into()<CR>", opt)
--     -- 弹窗
--     map("n", "<leader>dh", ":lua require'dapui'.eval()<CR>", opt)
-- end

-- vimspector
-- pluginKeys.mapVimspector = function()
--     -- 开始
--     map("n", "<leader>dd", ":call vimspector#Launch()<CR>", opt)
--     -- 结束
--     map("n", "<Leader>de", ":call vimspector#Reset()<CR>", opt)
--     -- 继续
--     map("n", "<Leader>dc", ":call vimspector#Continue()<CR>", opt)
--     -- 设置断点
--     map("n", "<Leader>dt", ":call vimspector#ToggleBreakpoint()<CR>", opt)
--     map("n", "<Leader>dT", ":call vimspector#ClearBreakpoints()<CR>", opt)
--     --  stepOver, stepOut, stepInto
--     map("n", "<leader>dj", "<Plug>VimspectorStepOver", opt)
--     map("n", "<leader>dk", "<Plug>VimspectorStepOut", opt)
--     map("n", "<leader>dl", "<Plug>VimspectorStepInto", opt)
-- end

-- nvim-cmp 自动补全
-- pluginKeys.cmp = function(cmp)
--     local feedkey = function(key, mode)
--         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
--     end
--     local has_words_before = function()
--         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--         return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--     end

--     return {
--         -- 上一个
--         ["<C-k>"] = cmp.mapping.select_prev_item(),
--         -- 下一个
--         ["<C-j>"] = cmp.mapping.select_next_item(),
--         -- 出现补全
--         ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--         -- 取消
--         ["<A-,>"] = cmp.mapping({
--             i = cmp.mapping.abort(),
--             c = cmp.mapping.close(),
--         }),
--         -- 确认
--         -- Accept currently selected item. If none selected, `select` first item.
--         -- Set `select` to `false` to only confirm explicitly selected items.
--         ["<CR>"] = cmp.mapping.confirm({
--             select = true,
--             behavior = cmp.ConfirmBehavior.Replace,
--         }),
--         -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--         -- 如果窗口内容太多，可以滚动
--         ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
--         ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
--         -- snippets 跳转
--         ["<C-l>"] = cmp.mapping(function(_)
--             if vim.fn["vsnip#available"](1) == 1 then
--                 feedkey("<Plug>(vsnip-expand-or-jump)", "")
--             end
--         end, { "i", "s" }),
--         ["<C-h>"] = cmp.mapping(function()
--             if vim.fn["vsnip#jumpable"](-1) == 1 then
--                 feedkey("<Plug>(vsnip-jump-prev)", "")
--             end
--         end, { "i", "s" }),

--         -- super Tab
--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif vim.fn["vsnip#available"](1) == 1 then
--                 feedkey("<Plug>(vsnip-expand-or-jump)", "")
--             elseif has_words_before() then
--                 cmp.complete()
--             else
--                 fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
--             end
--         end, { "i", "s" }),

--         ["<S-Tab>"] = cmp.mapping(function()
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif vim.fn["vsnip#jumpable"](-1) == 1 then
--                 feedkey("<Plug>(vsnip-jump-prev)", "")
--             end
--         end, { "i", "s" }),
--         -- end of super Tab
--     }
-- end

-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
-- pluginKeys.mapToggleTerm = function(toggleterm)
--     vim.keymap.set({ "n", "t" }, "<leader>ta", toggleterm.toggleA)
--     vim.keymap.set({ "n", "t" }, "<leader>tb", toggleterm.toggleB)
--     vim.keymap.set({ "n", "t" }, "<leader>tc", toggleterm.toggleC)
--     vim.keymap.set({ "n", "t" }, "<leader>tg", toggleterm.toggleG)
-- end

-- gitsigns
-- pluginKeys.gitsigns_on_attach = function(bufnr)
--     local gs = package.loaded.gitsigns

--     local function map(mode, l, r, opts)
--         opts = opts or {}
--         opts.buffer = bufnr
--         vim.keymap.set(mode, l, r, opts)
--     end

--     -- Navigation
--     map("n", "<leader>gj", function()
--         if vim.wo.diff then
--             return "]c"
--         end
--         vim.schedule(function()
--             gs.next_hunk()
--         end)
--         return "<Ignore>"
--     end, { expr = true })

--     map("n", "<leader>gk", function()
--         if vim.wo.diff then
--             return "[c"
--         end
--         vim.schedule(function()
--             gs.prev_hunk()
--         end)
--         return "<Ignore>"
--     end, { expr = true })

--     map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
--     map("n", "<leader>gS", gs.stage_buffer)
--     map("n", "<leader>gu", gs.undo_stage_hunk)
--     map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
--     map("n", "<leader>gR", gs.reset_buffer)
--     map("n", "<leader>gp", gs.preview_hunk)
--     map("n", "<leader>gb", function()
--         gs.blame_line({ full = true })
--     end)
--     map("n", "<leader>gd", gs.diffthis)
--     map("n", "<leader>gD", function()
--         gs.diffthis("~")
--     end)
--     -- toggle
--     map("n", "<leader>gtd", gs.toggle_deleted)
--     map("n", "<leader>gtb", gs.toggle_current_line_blame)
--     -- Text object
--     map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
-- end

-- TODO
-- 代码片段补全后会进入select模式，再这个模式下是没办法输入p的，但是react中经常要用到props，为了解决这个问题，在select模式下将p映射成p，而不是粘贴，这里处理的应该是有问题的，暂时没想到更好的办法
-- map("s", "p", "P", { noremap = true })
-- map("s", "P", "p", { noremap = true })

return pluginKeys
