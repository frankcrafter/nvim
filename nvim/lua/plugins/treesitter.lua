return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			highlight = {
				enable = true,
			},
			ensure_installed = { "lua" },
			auto_install = true,
		},
	},
}
