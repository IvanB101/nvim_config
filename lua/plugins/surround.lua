local remap = vim.keymap.set

return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	config = function()
		remap("o", "ir", "i[")
		remap("o", "ar", "a[")
		remap("o", "ia", "i<")
		remap("o", "aa", "a<")
		remap("o", "id", 'i"')
		remap("o", "ad", 'a"')

		require("nvim-surround").setup({
			aliases = {
				d = '"',
			},
			-- Configuration here, or leave empty to use defaults
		})
	end,
}
