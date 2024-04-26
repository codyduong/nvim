local config = {
	formatters_by_ft = {
		css = { "prettierd" },
		html = { "prettierd" },
		yaml = { "prettierd" },
		graphql = { "prettierd" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },

		python = { "isort", "black" },

		markdown = { "prettierd" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
	format_after_save = {
		lsp_fallback = true,
	},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
}

return config
