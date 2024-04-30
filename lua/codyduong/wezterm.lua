local M = {}

function M.on_init()
  -- Setting the iTerm2 user variable "IS_NVIM" to "true"
  io.stdout:write "\x1b]1337;SetUserVar=IS_NVIM=dHJ1ZQ==\007"
end

function M.on_exit()
  -- Clearing the iTerm2 user variable "IS_NVIM"
  io.stdout:write "\x1b]1337;SetUserVar=IS_NVIM\007"
end

-- Register these functions to fire at Neovim startup and exit
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = M.on_init,
})

vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = M.on_exit,
})

return M
