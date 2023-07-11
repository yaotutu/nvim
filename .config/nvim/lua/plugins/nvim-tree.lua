local function on_attach(bufnr)
  require("config.keymaps").nvimTreeList(bufnr)
end

return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      on_attach = on_attach,
      -- 完全禁止内置netrw
      disable_netrw = true,
      -- 不显示 git 状态图标
      git = {
        enable = true,
      },
      renderer = {
        root_folder_modifier = ":t",
        -- These icons are visible when you install web-devicons
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              untracked = "U",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      -- project plugin 需要这样设置
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      filters = {
        -- 隐藏 .文件
        dotfiles = true,
        -- 隐藏 node_modules 文件夹
        -- custom = { "node_modules" },
      },
      view = {
        -- 宽度
        width = 34,
        -- 也可以 'right'
        side = "left",
        -- 隐藏根目录
        hide_root_folder = false,
        -- 不显示行数
        number = false,
        relativenumber = false,
        -- 显示图标
        signcolumn = "yes",
      },
      actions = {
        open_file = {
          -- 首次打开大小适配
          resize_window = true,
          -- 打开文件时关闭 tree
          quit_on_open = false,
        },
      },
      -- wsl install -g wsl-open
      -- https://github.com/4U6U57/wsl-open/
      system_open = {
        -- mac
        cmd = "open",
        -- windows
        -- cmd = "wsl-open",
      },
    })
  end,
}
