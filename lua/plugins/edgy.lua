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
                {
                    title = "Spectre",
                    ft = "spectre_panel",
                    size = { height = 0.2 }
                },
                "Trouble",
                {
                    ft = "trouble",
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                {
                    ft = "noice",
                    size = { height = 0.2 },
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
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
                ["<leader>wl"] = function(win)
                    win:resize("width", 2)
                end,
                -- decrease width
                ["<leader>wh"] = function(win)
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
        }

        return opts
    end,
}
