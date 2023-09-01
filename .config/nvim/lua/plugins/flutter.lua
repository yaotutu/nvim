return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require("flutter-tools").setup {
            outline = {
                open_cmd = "10vnew", -- command to use to open the outline buffer
                auto_open = false    -- if true this will open the outline automatically when it is first populated
            },
        }
    end
}
