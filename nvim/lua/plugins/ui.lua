return {

	{
		"folke/snacks.nvim",
		lazy = false,
		opts = {
			scroll = { enabled = true },
			words = { enabled = true },
			notifier = { enabled = false },
			statuscolumn = { enabled = false },
			indent = { enabled = false },
			scope = { enabled = false },
		},
	},

	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				lsp_doc_border = true,
			},
			routes = {
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					{
						event = "msg_show",
						kind = "search_count",
					},
					opts = { skip = true },
				},
			},
		},
	},

	{

		"rcarriga/nvim-notify",
		opts = {
			timeout = 3500,
			animation = "slide",
			render = "wrapped-compact",
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = function()
			return {
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = { show_start = false, show_end = false },
			}
		end,
	},

	{
		"nvim-mini/mini.indentscope",
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
	},

	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		opts = function()
			local colors = require("solarized-osaka.colors").setup()
			return {
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			}
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local lualine = require("lualine")
			local colors = {
				bg = "#001014",
				fg = "#9eabac",
				red = "#db302d",
				green = "#849900",
				yellow = "#b28500",
				blue = "#278bd3",
				magenta = "#d23681",
				cyan = "#29a298",
			}
			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}
			local config = {
				options = {
					component_separators = "",
					section_separators = "",
					theme = {
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left({
				function()
					return ""
				end,
				color = { fg = colors.fg, bg = colors.green },
				padding = { right = 2, left = 2 },
			})

			ins_left({
				function()
					return ""
				end,
				cond = conditions.buffer_not_empty,
				color = { fg = colors.green, bg = colors.bg },
				padding = { left = 0, right = 1 },
			})

			ins_left({
				function()
					local msg = "searching..."
					local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
					local clients = vim.lsp.get_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				cond = conditions.buffer_not_empty,
				icon = "",
				color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
				padding = { left = 0, right = 1 },
			})

			ins_left({
				function()
					return ""
				end,
				cond = conditions.buffer_not_empty,
				color = { fg = colors.bg, bg = colors.bg },
				padding = { left = 0, right = 0 },
			})

			ins_right({
				"diff",
				symbols = { added = " ", modified = "󰝤 ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})

			ins_right({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = "  ", info = "  ", hint = " 󰌵 " },
				diagnostics_color = {
					error = { fg = colors.red, gui = "bold,italic" },
					warn = { fg = colors.yellow, gui = "bold" },
					info = { fg = colors.cyan, gui = "bold" },
					hint = { fg = colors.magenta, gui = "bold" },
				},
				cond = conditions.buffer_not_empty,
				always_visible = true,
				padding = { left = 0, right = 2 },
			})

			ins_right({
				function()
					return "│"
				end,
				cond = conditions.buffer_not_empty,
				color = { fg = colors.fg, bg = colors.bg },
				padding = { left = 0, right = 2 },
			})

			ins_right({
				function()
					return "󰦨"
				end,
				cond = conditions.buffer_not_empty,
				color = { bg = colors.bg, fg = colors.fg },
				padding = { left = 0, right = 0 },
			})

			ins_right({
				"location",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.fg, bg = colors.bg, gui = "italic" },
				padding = { left = 1, right = 1 },
			})

			ins_right({
				function()
					return "│"
				end,
				cond = conditions.buffer_not_empty,
				color = { fg = colors.fg },
				padding = { left = 0, right = 1 },
			})

			ins_right({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
				padding = { left = 0, right = 2 },
			})

			lualine.setup(config)
		end,
	},
}
