return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require("flutter-tools").setup {
            decorations = {
                statusline = {
                    -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
                    -- this will show the current version of the flutter app from the pubspec.yaml file
                    app_version = true,
                    -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
                    -- this will show the currently running device if an application was started with a specific
                    -- device
                    device = true,
                    -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
                    -- this will show the currently selected project configuration
                    project_config = true,
                }
            },
            widget_guides = {
                enabled = true,
            },
            dev_tools = {
                autostart = false,        -- autostart devtools server if not detected
                auto_open_browser = true, -- Automatically opens devtools in the browser
            },
            dev_log = {
                enabled = true,
                notify_errors = true, -- if there is an error whilst running then notify the user
                open_cmd = "tabedit",       -- command to use to open the log buffer
            },
        }
    end
}
