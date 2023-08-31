return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        {
            "mxsdev/nvim-dap-vscode-js",
            dependencies = {
                "mfussenegger/nvim-dap",
                {
                    "microsoft/vscode-js-debug",
                    lazy = true,
                    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
                }
            },
            config = function()
                local DEBUG_PATH = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"
                require("dap-vscode-js").setup({
                    debugger_path = DEBUG_PATH,
                    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
                    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
                })
                for _, language in ipairs({ "typescript", "javascript" }) do
                    require("dap").configurations[language] = {
                        {
                            type = "pwa-node",
                            request = "launch",
                            name = "Launch file",
                            program = "${file}",
                            cwd = "${workspaceFolder}",
                        },
                        {
                            type = "pwa-node",
                            request = "attach",
                            name = "Attach",
                            processId = require 'dap.utils'.pick_process,
                            cwd = "${workspaceFolder}",
                        }
                    }
                end
            end
        },
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
                automatic_installation = true,
                ensure_installed = {
                },
            },
        }
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        require("nvim-dap-virtual-text").setup()
        require("dapui").setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end
}
