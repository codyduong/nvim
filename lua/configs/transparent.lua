local options = {
	groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLine",
		"CursorLineNr",
		"StatusLine",
		"StatusLineNC",
		"EndOfBuffer",
	},
	extra_groups = {
		-- https://github.com/xiyaowong/transparent.nvim/issues/65#issue-2249602409
		"NvimTreeNormal",
		"NvimTreeNormalNC",
		"NvimTreeNormalFloat",
		"NvimTreeEndOfBuffer",

		"NormalFloat",
	},
	exclude_groups = {},
}

return options
