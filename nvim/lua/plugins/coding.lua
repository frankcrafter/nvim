return {

	{
		"nvim-mini/mini.pairs",
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},

	{
		"iamcco/markdown-preview.nvim",
		lazy = false,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
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
