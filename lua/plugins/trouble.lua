local remap = vim.keymap.set

remap("n", "<leader>sd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "show diagnostics" })
remap("n", "<leader>ss", "<cmd>Trouble symbols toggle<cr>", { desc = "show symbols" })

return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {
		focus = true,
	},
}
