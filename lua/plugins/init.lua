return {
	-- lsp
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function()
			return require("configs.mason-lspconfig")
		end,
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = {
			"MasonToolsInstall",
			"MasonToolsInstallSync",
			"MasonToolsUpdate",
			"MasonToolsUpdateSync",
			"MasonToolsClean",
		},
		opts = function()
			return require("configs.mason-tool-installer")
		end,
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		opts = function()
			return require("configs.nvm-lint")
		end,
		config = function(_, opts)
			local lint = require("lint")

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
			return require("configs.conform")
		end,
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},

	-- visual
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		opts = function()
			return require("configs.transparent")
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
			return require("configs.wilder")
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
			return require("configs.treesitter")
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "syntax")
			dofile(vim.g.base46_cache .. "treesitter")
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
