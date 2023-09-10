return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require("flutter-tools").setup {
            dev_log = {
                enabled = true,
                notify_errors = false, -- if there is an error whilst running then notify the user
                open_cmd = "sp",       -- command to use to open the log buffer
            },
        }
    end
}
