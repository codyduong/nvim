local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities


local options = {
  ensure_installed = {
    "lua_ls",
    "ast_grep",

    "tsserver",
    -- "javascript",
    -- "jsdoc",
    -- "tsx",
    -- "jsx",
    "html",
    "cssls", "cssmodules_ls",
    -- "scss",
    -- "phpactor", -- unsupported platform (windows)

    "prismals",
    "graphql",
    "csharp_ls",

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

    -- hardware
    "hdl_checker", -- vhdl
    "arduino_language_server",
    "asm_lsp"
  },

  automatic_installation = true,

  handlers = {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
      print("Setting up generic")
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
    ["lua_ls"] = function ()
print("Setting up Lua LS")
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
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
        }
      }
    end,
    ["powershell_es"] = function ()
      require("lspconfig")["powershell_es"].setup {
        root_dir = function() return vim.fn.getcwd() end
      }
    end
  },
}


return options
