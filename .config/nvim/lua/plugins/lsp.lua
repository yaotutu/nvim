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
            require('lspconfig').tsserver.setup {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', }
            }
            require('lspconfig').tailwindcss.setup {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
            }
            require('lspconfig').cssls.setup {}
            require 'lspconfig'.volar.setup {
                filetypes = { 'vue' }
            }
            require 'lspconfig'.emmet_language_server.setup {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
            }


            -- require 'lspconfig'.unocss.setup {}
        end
    },

}
