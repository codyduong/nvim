require "nvchad.mappings"

local format = require "codyduong.format"
local set = vim.keymap.set

set({ "n", "v" }, "<leader>cf", format.base, { desc = "Format file or range (in visual mode)" })
-- https://github.com/kaddkaka/vim_examples?tab=readme-ov-file#replace-only-within-selection
set("x", "s", ":<C-u>s/\\%V", { noremap = true, silent = false, desc = "Search (in visual mode)" })

local lint_augroup = vim.api.nvim_create_augroup("CQD", { clear = false })

-- delete stupid ass handler
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = lint_augroup,
  -- pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  -- format with conform, then lint with nvim-lint
  callback = format.base,
})

-- train repeaters
local discipline = require "codyduong.discipline"
discipline.setup_default_mappings()
discipline.cowboy(5)

-- i use D for delete and Y for yank, so delete should blackhole
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("v", "d", '"_d', { noremap = true })
