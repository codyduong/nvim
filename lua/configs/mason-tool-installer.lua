local options = {
  ensure_installed = {
    -- linters
    "eslint_d",

    "pylint",

    -- formatters
    "stylua",

    "prettier",
    "prettierd",

    "isort",
    "black",
  },

  auto_update = false,
  run_on_start = true,
}

return options
