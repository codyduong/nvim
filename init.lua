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

-- until Mason fixes pyenv loading: https://github.com/williamboman/mason.nvim/issues/1753
local python_executable, python_dir, error_message
if vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 then
  python_executable, python_dir, error_message = require("codyduong.utils").find_highest_pyenv_python()
  if python_executable then
    vim.g.python3_host_prog = python_executable
    vim.env.PATH = python_dir .. ';' .. vim.env.PATH
  end
end

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

-- after loading we can notify about any earlier errors
if python_executable then
  vim.notify("Using Python from: " .. python_executable)
else
  vim.notify("Error loading Python from pyenv: " .. error_message, vim.log.levels.ERROR)
end

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

if vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""

  -- custom path resolver for ~ literal
  vim.env.HOME = os.getenv "USERPROFILE"

  -- if we are using pwsh, start immediately float term to minimize downtime
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
  -- immediately toggle it closed
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
  -- switch back to normal mode
  vim.cmd "stopinsert"
else
  vim.o.shell = "/bin/zsh"
end

vim.lsp.set_log_level "trace"

-- for wezterm
require "codyduong.wezterm"
