local opts = {
	open_mapping = "<C-t>",
	direction = "float",
}

local function config()
	require("toggleterm").setup(opts)

	vim.api.nvim_create_autocmd("TermOpen", {
		pattern = "term://*toggleterm#*",
		callback = function()
			vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = 0 })
		end,
	})
end

return {
	"akinsho/toggleterm.nvim",
	config = config,
}
