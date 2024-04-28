local M = {}

M.base = function(args)
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
    require("conform").format({
      lsp_fallback = true,
      bufnr = bufnr,
      async = true,
      timeout_ms = 500,
    }, function()
      vim.cmd "e!"
      vim.cmd "EslintFixAll"
      vim.cmd "sleep 1ms"
      vim.fn.winrestview(view)
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
