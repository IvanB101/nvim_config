return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("o", "ir", "i[")
		vim.keymap.set("o", "ar", "a[")
		vim.keymap.set("o", "ia", "i<")
		vim.keymap.set("o", "aa", "a<")
		vim.keymap.set("o", "id", 'i"')
		vim.keymap.set("o", "ad", 'a"')

		require("nvim-surround").setup({
			aliases = {
				d = '"',
			},
			-- Configuration here, or leave empty to use defaults
		})
	end,
}
