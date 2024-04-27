require "nvchad.mappings"

local conform = require "conform"
local lint = require "lint"

local set = vim.keymap.set

set({ "n", "v" }, "<leader>cf", function()
  conform.format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }
end, { desc = "Format file or range (in visual mode)" })

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

set("n", "<leader>cl", function()
  lint.try_lint()
end, { desc = "Lint toggle" })

-- vim.api.nvim_create_autocmd({
--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--     callback = function(ev)
--       -- Enable completion triggered by <c-x><c-o>
--       vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
--
--       -- Buffer local mappings.
--       -- See `:help vim.lsp.*` for documentation on any of the below functions
--       local opts = { buffer = ev.buf, desc = "Lsp" }
--       vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--       vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--       vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--       vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--       vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--       vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--       vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--       vim.keymap.set('n', '<space>wl', function()
--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--       end, opts)
--       vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--       vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--       vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
--       vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--       vim.keymap.set('n', '<space>f', function()
--         vim.lsp.buf.format { async = true }
--       end, opts)
--     end,
--   }, 'LspAttach')
--
