return {
  'rmagatti/goto-preview',
  config = function()
    require('goto-preview').setup {
      --   -- Close the current preview window with <Esc>
      post_open_hook = function(_, win)
        vim.keymap.set(
          'n',
          'q',
          function()
            vim.api.nvim_win_close(win, true)
          end,
          { buffer = true }
        )
      end,
    }
  end
}
