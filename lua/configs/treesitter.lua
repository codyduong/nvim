local options = {
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",

		-- f/e web
		"typescript",
		"javascript",
		"jsdoc",
		"tsx",
		-- "jsx",
		"html",
		"http",
		"css",
		"scss",
		"php",

		-- b/e web
		"prisma",
		"graphql",
		"c_sharp",

		-- general
		"python",

		"c",
		"make",
		"cpp",
		"cmake",
		"doxygen",
		-- "just", not found? doesn't matter don't use much

		"haskell",
		"rust",

		-- data
		"json",
		"json5",
		"yaml",
		"toml",
		"markdown_inline",

		-- git
		"diff",
		"gitignore",
		"git_config",
		"git_rebase",
		"gitcommit",
		"gitattributes",

		-- shell
		"bash",

		-- hardware
		"verilog",
		"arduino",
		"asm",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
}

return options
