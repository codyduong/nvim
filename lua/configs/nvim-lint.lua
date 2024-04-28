local config = {
  linters_by_ft = {
    -- Use eslint-lsp instead!
    -- javascript = { "eslint_d" },
    -- typescript = { "eslint_d" },
    -- javascriptreact = { "eslint_d" },
    -- typescriptreact = { "eslint_d" },

    python = { "pylint" },

    bash = { "shellharden" },
  },
}

return config
