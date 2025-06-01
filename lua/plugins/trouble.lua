local remap = vim.keymap.set

remap("n", "<leader>sd", "<cmd>Trouble diagnostics toggle focus=true<cr>", { desc = "show diagnostics" })
remap(
	"n",
	"<leader>se",
	"<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR<cr>",
	{ desc = "show diagnostics" }
)
remap("n", "<leader>sbd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "show buffer diagnostics" })
remap(
	"n",
	"<leader>sbe",
	"<cmd>Trouble diagnostics toggle focus=true filter.severity=vim.diagnostic.severity.ERROR filter.buf=0<cr>",
	{ desc = "show diagnostics" }
)
remap("n", "<leader>ss", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "show symbols" })

return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	config = true,
}
