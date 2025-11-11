return {

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = { "lua_ls" },
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = {
								"vim",
							},
						},
					},
				},
			})
			vim.lsp.enable("lua_ls", "ts_ls", "html", "cssls", "tailwindcss")
			-- diagnostics signs
			vim.diagnostic.config({
				virtual_text = {
					source = "if_many",
					prefix = "■",
				},
				underline = true,
				update_in_insert = true,
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = " ",
					},
				},
			})
		end,
	},

	{
		"nvim-flutter/flutter-tools.nvim",
		opts = {},
	},

	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = {
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 300,
				},
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
				ghost_text = {
					enabled = true,
					show_with_selection = true,
					show_without_selection = true,
				},
			},
			cmdline = {
				enabled = false,
			},
		},
	},

	-- Formatters
	{
		"stevearc/conform.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
			opts = {},
		},
		opts = {
			format_on_save = {
				timeout_ms = 200,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
			},
		},
	},
}
