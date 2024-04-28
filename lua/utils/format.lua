local M = {}

M.clear_specific_autocmds = function(group_name, events)
  -- Fetch all autocommands in the specified group
  local autocmds = vim.api.nvim_get_autocmds { group = group_name }

  -- Iterate through each autocommand and clear specific events
  for _, autocmd in pairs(autocmds) do
    if vim.tbl_contains(events, autocmd.event) then
      -- Clear this specific autocommand
      vim.api.nvim_del_autocmd(autocmd.id)
    end
  end
end

local util = require "lspconfig.util"
local lsp = vim.lsp
-- https://github.com/neovim/nvim-lspconfig/blob/7133e85c3df14a387da8942c094c7edddcdef309/lua/lspconfig/server_configurations/eslint.lua
local function fix_all(opts)
  opts = opts or {}

  local eslint_lsp_client = util.get_active_client_by_name(opts.bufnr, "eslint")
  if eslint_lsp_client == nil then
    return
  end

  local request
  if opts.sync then
    request = function(bufnr, method, params)
      eslint_lsp_client.request_sync(method, params, nil, bufnr)
    end
  else
    request = function(bufnr, method, params)
      eslint_lsp_client.request(method, params, nil, bufnr)
    end
  end

  local bufnr = util.validate_bufnr(opts.bufnr or 0)
  request(0, "workspace/executeCommand", {
    command = "eslint.applyAllFixes",
    arguments = {
      {
        uri = vim.uri_from_bufnr(bufnr),
        version = lsp.util.buf_versions[bufnr],
      },
    },
  })
end

M.base = function(args)
  args = args or {}
  local view = vim.fn.winsaveview()
  local bufnr = args.buf or vim.api.nvim_get_current_buf()

  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

  if
    vim.fn.exists ":EslintFixAll"
    and (
      filetype == "typescript"
      or filetype == "javascript"
      or filetype == "typescriptreact"
      or filetype == "javascriptreact"
    )
  then
    -- just use lsp if we have it, assuming eslint is configured to run prettier itself
    -- vim.cmd("EslintFixAll")

    require("conform").format({
      lsp_fallback = true,
      bufnr = bufnr,
      async = false,
      timeout_ms = 1000,
    }, function(_err, did_edit)
      if did_edit then
        vim.cmd "e!"
      end

      fix_all { sync = true, bufnr = bufnr }
      vim.fn.winrestview(view)
      -- vim.fn.winrestview(view)
    end)

    return
  end

  require("conform").format {
    lsp_fallback = true,
    bufnr = bufnr,
    async = true,
    timeout_ms = 500,
  }
end

return M
