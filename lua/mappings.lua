require "nvchad.mappings"

local format = require "utils.format"
local set = vim.keymap.set

set({ "n", "v" }, "<leader>cf", format.base, { desc = "Format file or range (in visual mode)" })

local lint_augroup = vim.api.nvim_create_augroup("CQD", { clear = false })

-- delete stupid ass handler
format.clear_specific_autocmds("Conform", { "BufWritePre", "BufWritePost" })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = lint_augroup,
  -- pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  -- format with conform, then lint with nvim-lint
  callback = format.base,
})
