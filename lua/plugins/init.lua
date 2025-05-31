local plugins = {
	{ "lewis6991/gitsigns.nvim" },
	{ "mfussenegger/nvim-jdtls" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},
	{ "barreiroleo/ltex_extra.nvim" },
	{
		"tiagovla/tokyodark.nvim",
		config = function(_, _)
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		lazy = false, -- This plugin is already lazy
	},
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		dependencies = { "hrsh7th/nvim-cmp" },
		config = true,
		-- TODO insert crate sources in nvim-cmp
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		config = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{
		"julianolf/nvim-dap-lldb",
		dependencies = { "mfussenegger/nvim-dap" },
	},
}

return plugins
