return {
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "williamboman/mason.nvim"
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
            require('lspconfig').lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                    },
                },

            }
            require('lspconfig').tsserver.setup {}
            -- require('lspconfig').tailwindcss.setup {}
            require 'lspconfig'.volar.setup {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
            }
            -- require 'lspconfig'.unocss.setup {}
        end
    },

}
