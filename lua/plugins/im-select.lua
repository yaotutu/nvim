return {
    'keaising/im-select.nvim',
    enabled=true,
    config = function()
        require('im_select').setup({
            default_command = 'im-select',
        })
    end
}
