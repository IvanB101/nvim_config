local ignored = { "latex" }

-- FIX: ignores wgsl ignores ts config
vim.api.nvim_create_autocmd("Filetype", {
	pattern = "wgsl",
	callback = function()
		vim.cmd("TSEnable highlight")
	end,
})

return {
	{ "nvim-treesitter/playground" },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
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
