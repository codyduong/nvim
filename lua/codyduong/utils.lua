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

M.find_highest_pyenv_python = function()
  local user_profile = vim.fn.getenv 'USERPROFILE'
  local pyenv_versions_dir = user_profile .. '\\.pyenv\\pyenv-win\\versions'

  local handle = io.popen('dir /b /ad "' .. pyenv_versions_dir .. '"')
  if not handle then
    return nil, nil, "Failed to list pyenv versions directory."
  end

  local versions = {}
  for version in handle:lines() do
    if version:match('^%d+%.%d+%.%d+$') then
      table.insert(versions, version)
    end
  end
  handle:close()

  if #versions == 0 then
    return nil, nil, "No valid Python versions found in pyenv."
  end

  table.sort(versions, function(a, b)
    local a_parts = {}
    for part in a:gmatch('%d+') do
      table.insert(a_parts, tonumber(part))
    end
    local b_parts = {}
    for part in b:gmatch('%d+') do
      table.insert(b_parts, tonumber(part))
    end
    for i = 1, math.max(#a_parts, #b_parts) do
      local a_val = a_parts[i] or 0
      local b_val = b_parts[i] or 0
      if a_val ~= b_val then
        return a_val > b_val
      end
    end
    return false
  end)

  local highest_version = versions[1]
  local python_executable = pyenv_versions_dir .. '\\' .. highest_version .. '\\python.exe'
  local python_dir = pyenv_versions_dir .. '\\' .. highest_version

  if vim.fn.filereadable(python_executable) == 1 then
    return python_executable, python_dir, nil
  else
    return nil, nil, "Python executable not found for version: " .. highest_version
  end
end

return M
