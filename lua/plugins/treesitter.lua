local ignored = { "latex" }

return {
	{ "nvim-treesitter/playground" },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = {
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"javascript",
				"typescript",
				"rust",
			},
			sync_install = false,
			ignore_install = ignored,
			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,
			highlight = {
				enable = true,
				disable = ignored,
				additional_vim_regex_highlighting = false,
			},
		},
	},
}
