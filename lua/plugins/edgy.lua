return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>ue",
            function()
                require("edgy").toggle()
            end,
            desc = "Edgy Toggle",
        },
        -- stylua: ignore
        { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
    opts = function()
        local opts = {
            bottom = {
                { ft = "qf", title = "QuickFix" },
                {
                    ft = "noice",
                    size = { height = 0.2 },
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                {
                    ft = "lazyterm",
                    title = "LazyTerm",
                    size = { height = 0.2 },
                    filter = function(buf)
                        return not vim.b[buf].lazyterm_cmd
                    end,
                },
                "Trouble",
                {
                    ft = "trouble",
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                { ft = "qf", title = "QuickFix" },
                {
                    ft = "help",
                    size = { height = 20 },
                    -- don't open help files in edgy that we're editing
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                },
                { title = "Spectre", ft = "spectre_panel", size = { height = 0.2 } },
                {
                    ft = "toggleterm",
                    size = { height = 0.2 },
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
            },
            keys = {
                -- increase width
                ["<leader>wh"] = function(win)
                    win:resize("width", 2)
                end,
                -- decrease width
                ["<leader>wl"] = function(win)
                    win:resize("width", -2)
                end,
                -- increase height
                ["<leader>wk"] = function(win)
                    win:resize("height", 2)
                end,
                -- decrease height
                ["<leader>wj"] = function(win)
                    win:resize("height", -2)
                end,
                ["<leader>w="] = function(win)
                    win.view.edgebar:equalize()
                end,
            },
            fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
        }

        return opts
    end,
}
