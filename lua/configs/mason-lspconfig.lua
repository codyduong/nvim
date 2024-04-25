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

  -- handlers = {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    -- function (server_name) -- default handler (optional)
    --     require("lspconfig")[server_name].setup {}
    -- end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
  -- },
}

return options
