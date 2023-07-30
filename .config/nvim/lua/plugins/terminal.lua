return {
    {
        'akinsho/toggleterm.nvim', 
        version = "*", 
        config = function ()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                      return 10
                    elseif term.direction == "vertical" then
                      return vim.o.columns * 0.2
                    end
                  end,
                open_mapping = [[<c-\>]],
                float_opts = {
                    border =  'double'
                  },
               })
               function _G.set_terminal_keymaps()
                 local opts = {noremap = true}
                 vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
                 vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
                 vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
                 vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
                 vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
                 vim.api.nvim_buf_set_keymap(0, "n", "h", ":ToggleTerm direction=float<CR>", opts)

               end
               
               vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
               
               local Terminal = require("toggleterm.terminal").Terminal
               local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
               
               function _LAZYGIT_TOGGLE()
                lazygit:toggle()
               end
               
               local node = Terminal:new({ cmd = "node", hidden = true })
               
               function _NODE_TOGGLE()
                node:toggle()
               end
               
               local python = Terminal:new({ cmd = "python3", hidden = true })
               
               function _PYTHON_TOGGLE()
                python:toggle()
               end 
    end
}

}