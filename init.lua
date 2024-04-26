
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  vim.o.shell = 'pwsh'
  vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
  vim.o.shellquote = ''
  vim.o.shellxquote = ''

  -- if we are using pwsh, start immediately float term to minimize downtime
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
  -- immediately toggle it closed
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
  -- switch back to normal mode
  vim.cmd("stopinsert")
else
  vim.o.shell = '/bin/zsh'
end

vim.lsp.set_log_level("trace")
