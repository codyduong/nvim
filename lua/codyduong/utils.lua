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

return M
