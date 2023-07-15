return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = {
            "bash",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "tsx",
            "typescript",
            "vim",
            "yaml",
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
}
