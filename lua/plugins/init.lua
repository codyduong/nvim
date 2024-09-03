return {
  -- lsp
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "nvchad.configs.mason"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      return require "configs.mason-lspconfig"
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    event = "BufReadPre",
    cmd = {
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateSync",
      "MasonToolsClean",
    },
    opts = function()
      return require "configs.mason-tool-installer"
    end,
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = function()
      return require "configs.typescript-tools"
    end,
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },

  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    opts = function()
      return require "configs.nvim-lint"
    end,
    config = function(_, opts)
      local lint = require "lint"

      lint.linters_by_ft = opts.linters_by_ft
    end,
  },

  {
    "stevearc/conform.nvim",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    opts = function()
      return require "configs.conform"
    end,
    config = function(_, opts)
      local conform = require "conform"

      conform.setup(opts)

      require("codyduong.utils").clear_specific_autocmds("Conform", { "BufWritePre", "BufWritePost" })
    end,
  },

  -- visual
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = function()
      return require "configs.transparent"
    end,
    config = function(_, opts)
      require("transparent").setup(opts)
    end,
  },

  -- command autocomplete recommendation
  {
    "gelguy/wilder.nvim",
    lazy = false,
    opts = function()
      return require "configs.wilder"
    end,
    config = function(_, opts)
      require("wilder").setup(opts)
    end,
  },

  -- fix treesitter installs
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")
      require("nvim-treesitter.configs").setup(opts)
      local styled = require "codyduong.styled"
      styled.directives()
      styled.queries()
    end,
  },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = function()
      return require "configs.nvim-notify"
    end,
    config = function(_, opts)
      local notify = require "notify"

      notify.setup(opts)

      vim.notify = notify
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- { path = "wezterm-types", words = {"wezterm"} },
        { path = "C:\\Users\\duong\\hitokage", words = { "hitokage" } },
      },
    },
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
    },
    config = function()
      require("auto-session").setup {
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    lazy = false,
    opts = function()
      return require "configs.trouble"
    end,
    config = function(_, opts)
      require("trouble").setup(opts)
    end,
  },
}
