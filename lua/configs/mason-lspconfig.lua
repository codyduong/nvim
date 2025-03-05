local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services"
local command_fmt =
  [[& '%s/PowerShellEditorServices/Start-EditorServices.ps1' -BundledModulesPath '%s' -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es.session.json' -FeatureFlags @() -AdditionalModules @() -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio -LogLevel Normal]]
local temp_path = vim.fn.stdpath "cache"
local command = command_fmt:format(bundle_path, bundle_path, temp_path, temp_path)

local options = {
  ensure_installed = {
    "lua_ls",
    -- "ast_grep",

    "tsserver",
    -- "javascript",
    -- "jsdoc",
    -- "tsx",
    -- "jsx",
    "html",
    "cssls",
    "cssmodules_ls",
    -- "scss",
    -- "phpactor", -- unsupported platform (windows)
    "eslint", -- this is the eslint-lsp for the linter

    "prismals",
    "graphql",
    -- "csharp_ls",

    "pylsp",
    "pyright",

    "clangd",
    "cmake",
    -- "cpptools", "cpplint",
    -- "doxygen",
    -- "just",

    -- "hls", -- haskell, fails to configure
    "rust_analyzer",

    "jsonls",
    "yamlls",
    -- "toml",
    -- "markdown_inline"

    -- shell
    "bashls",
    "powershell_es",

    "ruff",
    "ruff_lsp",

    -- hardware
    -- "hdl_checker", -- vhdl
    -- "arduino_language_server",
    -- "asm_lsp",
  },

  automatic_installation = true,

  handlers = {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      -- print("Setting up " .. server_name)
      require("lspconfig")[server_name].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
    ["lua_ls"] = function()
      local lspconfig = require "lspconfig"
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "wezterm" },
            },
          },
          format = {
            enable = true,
            indent_style = "space",
            indent_size = 2,
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      }
    end,
    ["clangd"] = function()
      require("lspconfig")["clangd"].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,

        root_dir = function()
          return vim.fn.getcwd()
        end,
      }
    end,
    ["powershell_es"] = function()
      require("lspconfig")["powershell_es"].setup {
        root_dir = function()
          return vim.fn.getcwd()
        end,
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,

        -- https://github.com/neovim/nvim-lspconfig/issues/2747
        bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
        cmd = { "pwsh", "-NoLogo", "-Command", command },
        filetypes = { "ps1", "psm1", "psd1" },
        -- https://github.com/PowerShell/PowerShellEditorServices/issues/2092#issuecomment-1773860748
        init_options = {
          enableProfileLoading = false,
        },
      }
    end,
    -- ["eslint"] = function()
    -- 	require("lspconfig")["eslint"].setup({
    -- 		on_attach = function(server, bufnr)
    -- 			on_attach(server, bufnr)
    -- 		end,
    -- 	})
    -- end,
    ["tsserver"] = function()
      -- use typescript-tools instead
    end,
    ["rust_analyzer"] = function()
      require("lspconfig")["rust_analyzer"].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            command = "clippy",
            features = "all",
          }
        }
      }
    end
  },
}

return options
