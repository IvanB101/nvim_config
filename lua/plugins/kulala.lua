vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>r",
		kulala_keymaps_prefix = "",
		lsp = {
			filetypes = { "http", "rest", "json", "yaml", "bruno", "javascript" },
		},
	},
}
