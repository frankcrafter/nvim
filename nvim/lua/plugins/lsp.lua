return {

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
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
			vim.diagnostic.config({
				virtual_text = {
					source = "if_many",
					prefix = "●",
				},
				underline = true,
				update_in_insert = true,
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = "󰛨 ",
					},
				},
			})
			vim.lsp.enable("lua_ls", "ts_ls", "html", "cssls", "tailwindcss")
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end)
			vim.keymap.set("n", "gn", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},

	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		opts = {},
	},

	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"saghen/blink.compat",
				optional = true, -- make optional so it's only enabled if any extras need it
				opts = {},
				version = not vim.g.lazyvim_blink_main and "*",
			},
		},
		version = "1.*",
		opts = {
			completion = {
				list = {
					selection = {
						preselect = false,
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
					enabled = vim.g.ai_cmp,
				},
			},
			cmdline = {
				enabled = false,
			},
			keymap = {
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "select_and_accept", "fallback" },
			},
			fuzzy = { implementation = "lua" },
		},
	},

	{
		"nvimtools/none-ls.nvim",
		opts = {},
		{
			"stevearc/conform.nvim",
			opts = {
				format_on_save = {
					timeout_ms = 300,
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
	},
}
