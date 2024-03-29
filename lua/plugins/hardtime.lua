return {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = function()
        require("hardtime").setup({
            disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
            disabled_keys = {
                ["<Up>"] = {},
                ["<Down>"] = {},
                ["<Left>"] = {},
                ["<Right>"] = {},
            },
            max_count = 1000000,
            max_time = 500000000,
        })
    end
}
