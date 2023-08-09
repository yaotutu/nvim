return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync" },
        opts = {
            ensure_installed = {},
            autotag = {
                enable = true,
            },
            highlight = { enable = true },
            indent = { enable = true },
            fold = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    node_decremental = "<BS>",
                    scope_incremental = "<TAB>",
                },
            },
            
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            vim.cmd([[set foldmethod=expr]])
            vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
            vim.cmd([[set nofoldenable]])
            vim.opt.foldlevel = 99
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = { "BufReadPost", "BufNewFile" },
        after = { "nvim-treesitter" },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },
            })
        end,
    }
}
