return {
  'rmagatti/goto-preview',
  config = function()
    require('goto-preview').setup {
      post_open_hook = function(_, win)
        -- Close the current preview window with <Esc>
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
