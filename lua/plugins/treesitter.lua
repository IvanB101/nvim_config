local ignored = { "latex" }

return {
	{ "nvim-treesitter/playground" },
	{
		"nvim-treesitter/nvim-treesitter",
		version = "v0.9.*",
		lazy = false,
		main = "nvim-treesitter.configs", -- TODO: remove when migrated to 0.12
		opts = {
			ensure_installed = {
				"c",
				"java",
				"javascript",
				"lua",
				"markdown",
				"markdown_inline",
				"typescript",
				"query",
				"rust",
				"vim",
				"vimdoc",
				"wgsl",
				"zig",
			},
			sync_install = false,
			ignore_install = ignored,
			auto_install = true,
			highlight = {
				enable = true,
				disable = ignored,
				additional_vim_regex_highlighting = false,
			},
		},
	},
}
