return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				signs = false,
				underline = true,
				update_in_insert = false,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
        ensure_installed = { "pylint", "black" }
      })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright" },
				handlers = {
					function(server_name)
						vim.lsp.enable(server_name)
					end,
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				python = { "black" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				python = { "pylint" },
			}
		end,
	},
	{ "towolf/vim-helm" },
	{
		"lervag/vimtex",
		enable = false,
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtext_compiler_method = "latexmk"
			vim.g.vimtex_syntax_enabled = 0
		end,
	},
}
