return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
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
