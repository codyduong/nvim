require "nvchad.mappings"

local conform = require "conform"
local lint = require "lint"
local format = require "utils.format"

local set = vim.keymap.set

set({ "n", "v" }, "<leader>cf", format.base, { desc = "Format file or range (in visual mode)" })

local lint_augroup = vim.api.nvim_create_augroup("CQD", { clear = false })

-- webdev
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = lint_augroup,
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  -- format with conform, then lint with nvim-lint
  callback = require("utils.format").base,
})

-- default save
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	group = lint_augroup,
--
-- 	-- format with conform, then lint with nvim-lint
-- 	callback = function(args)
-- 		require("conform").format({
-- 			bufnr = args.buf,
-- 			callback = function()
-- 				lint.try_lint()
-- 				-- ^^ try_lint is synchronous, so finally use lsp
-- 				if vim.lsp.buf.server_capabilities.documentFormattingProvider then
-- 					vim.lsp.buf.format({ async = true })
-- 				end
-- 			end,
-- 		})
-- 	end,
-- })

-- set("n", "<leader>cl", function()
-- 	lint.try_lint()
-- end, { desc = "Lint file" })

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
