local remap = vim.keymap.set

return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	config = function()
		local aliases = {
			r = "[",
			a = "<",
			d = '"',
		}

		for alias, original in pairs(aliases) do
			remap("o", "i" .. alias, "i" .. original)
			remap("o", "a" .. alias, "a" .. original)
			remap("v", "i" .. alias, "i" .. original)
			remap("v", "a" .. alias, "a" .. original)
		end

		require("nvim-surround").setup({
			aliases = aliases,
		})
	end,
}
