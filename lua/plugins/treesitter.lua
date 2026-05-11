local ignored = { "latex" }

-- FIX: for these filetypes enable ts highlights are not automatically enabled
vim.api.nvim_create_autocmd("Filetype", {
	pattern = {"wgsl", "http", "odin"},
	callback = function()
		vim.cmd("TSEnable highlight")
	end,
})

return {
	{ "nvim-treesitter/playground" },
	{
		"nvim-treesitter/nvim-treesitter",
		version = "v0.9.*",
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
			auto_install = true,
			highlight = {
				enable = true,
				disable = ignored,
				additional_vim_regex_highlighting = false,
			},
		},
	},
}
