local options = {
	ensure_installed = {
		-- linters
		"eslint_d",

		"pylint",

		-- formatters
		"stylua",

		"prettier",
		"prettierd",

		"isort",
		"black",

		-- linters & formatters
		"shellharden",
		"shfmt",
	},

	auto_update = false,
	run_on_start = true,
}

return options
