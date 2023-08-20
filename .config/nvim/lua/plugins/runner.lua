return {
    "CRAG666/code_runner.nvim",
    config = function()
        require('code_runner').setup({
            filetype = {
                java = {
                    "cd $dir &&",
                    "javac $fileName &&",
                    "java $fileNameWithoutExt"
                },
                python = "python3 -u",
                typescript = "deno run",
                rust = {
                    "cd $dir &&",
                    "rustc $fileName &&",
                    "$dir/$fileNameWithoutExt"
                },
                javascript = 'node',
                go = "go run",

            },
            float = {
                close_key = "<ESC>",
                -- Window border (see ':h nvim_open_win')
                border = "double",

                -- Num from `0 - 1` for measurements
                height = 0.5,
                width = 0.5,
                x = 0.5,
                y = 0.5,

                -- Highlight group for floating window/border (see ':h winhl')
                border_hl = "FloatBorder",
                float_hl = "Normal",

                -- Transparency (see ':h winblend')
                blend = 50,
            },
        })
    end
}
