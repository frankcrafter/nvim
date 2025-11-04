return {
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				always_show_bufferline = false,
				mode = "tabs",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
		},
	},

	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			render = "background",
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_hsl_without_function = true,
			enable_ansi = true,
			enable_var_usage = true,
			enable_tailwind = true,
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		keys = {
			{
				"ff",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({
						no_ignore = false,
						hidden = true,
					})
				end,
			},
			{
				";l",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep({
						additiona_args = { "--hidden" },
					})
				end,
			},
			{
				";d",
				function()
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
			},
			{
				"\\\\",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
			},
			{
				";;",
				function()
					local telescope = require("telescope")

					local function telescope_buffer_dir()
						return vim.fn.expand("%:p:h")
					end

					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = telescope_buffer_dir(),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal",
						layout_config = {
							height = 15,
						},
					})
				end,
			},
		},
		opts = function()
			return {
				extensions = {
					file_browser = {
						theme = "dropdown",
						layout_config = {
							preview_cutoff = 9999,
						},
						initial_mode = "normal",
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						layout_config = {
							preview_cutoff = 9999,
						},
					},
					diagnostics = {
						theme = "dropdown",
						layout_config = {
							preview_cutoff = 9999,
						},
						initial_mode = "normal",
					},
					live_grep = {
						sorting_strategy = "ascending",
						layout_config = {
							preview_width = 0.45,
							horizontal = {
								width = 0.95,
								height = 20,
							},
							preview_cutoff = 0,
							prompt_position = "top",
						},
					},
					buffers = {
						sorting_strategy = "ascending",
						layout_config = {
							preview_width = 0.45,
							horizontal = {
								width = 0.95,
								height = 20,
							},
							preview_cutoff = 0,
							prompt_position = "top",
						},
						initial_mode = "normal",
					},
				},
			}
		end,
	},
}
