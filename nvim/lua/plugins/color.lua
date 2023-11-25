return {
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme catppuccin-frappe ]]
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = true
                }
            })
        end
    },
}
