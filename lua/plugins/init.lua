return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      return require "configs.mason-lspconfig"
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = function()
      return require "configs.transparent"
    end,
    config = function(_, opts)
      require("transparent").setup(opts)
    end
  },

  {
    "gelguy/wilder.nvim",
    lazy = false,
    opts = function()
      return require "configs.wilder"
    end,
    config = function(_, opts)
      require("wilder").setup(opts)
    end
  },

  -- nvchad 2.5 /lua/nvchad/plugs/ui.lua crashes
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },
}
