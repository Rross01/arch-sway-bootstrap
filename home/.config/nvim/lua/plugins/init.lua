return {
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "windwp/nvim-autopairs", config = true },
	{ "brenoprata10/nvim-highlight-colors", config = true },
	{ "tpope/vim-fugitive" },
	{ "nvim-pack/nvim-spectre" },
	{ "powerman/vim-plugin-ruscmd" },
	{ "lepture/vim-jinja" },
	{ "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
		opts = {
			defaults = {
				borderchars = {
					prompt = { "─", " ", "─", "│", "│", " ", "─", "└" },
					results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
					preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
				},
			},
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	},

	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme github_dark")
		end,
	},

	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.cursorword").setup() -- Autohighlight word under cursor
			require("mini.move").setup() -- Move any selection in any direction
			require("mini.splitjoin").setup() -- Split and join arguments (g + S)
			require("mini.bufremove").setup() -- Remove buffers
			require("mini.comment").setup() -- Comment lines
		end,
		keys = {
			{
				"<leader>d",
				function()
					require("mini.bufremove").delete()
				end,
			},
			{
				"gS",
				function()
					require("mini.splitjoin").toggle()
				end,
			},
		},
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"fr",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
				yaml = { "yamlfmt" },
				sh = { "beautysh" },
			},
		},
	},

	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = {
			{
				"<leader>u",
				function()
					require("undotree").toggle()
				end,
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"helm",
					"json",
					"jsonc",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"vim",
					"vimdoc",
					"yaml",
				},
				highlight = { enable = true },
			})
		end,
	},
}
