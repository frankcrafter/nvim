return {

	{
		"nvim-mini/mini.pairs",
		opts = {},
	},

	{
		"nvim-mini/mini.bracketed",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},
}
