return {
	{
		"craftzdog/solarized-osaka.nvim",
		config = function()
			require("solarized-osaka").setup({
				transparent = true,
			})
			vim.cmd([[colorscheme solarized-osaka]])
		end,
	},
}
