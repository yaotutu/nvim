return {
    on_setup = function(server)
      server.setup({
        settings = {
            config = {
              css = {},
              emmet = {},
              html = {
                suggest = {}
              },
              javascript = {
                format = {}
              },
              stylusSupremacy = {},
              typescript = {
                format = {}
              },
              vetur = {
                completion = {
                  autoImport = false,
                  tagCasing = "kebab",
                  useScaffoldSnippets = false
                },
                format = {
                  defaultFormatter = {
                    js = "none",
                    ts = "none"
                  },
                  defaultFormatterOptions = {},
                  scriptInitialIndent = false,
                  styleInitialIndent = false
                },
                useWorkspaceDependencies = false,
                validation = {
                  script = true,
                  style = true,
                  template = true
                }
              }
            }
          },

        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        flags = {
          debounce_text_changes = 150,
        },
        on_attach = function(client, bufnr)
          -- 禁用格式化功能，交给专门插件插件处理
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
          -- 绑定快捷键
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end
          require("keybindings").mapLSP(buf_set_keymap)
        end,
      })
    end,
  }
  