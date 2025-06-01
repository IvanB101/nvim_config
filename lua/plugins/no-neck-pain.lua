local remap = vim.keymap.set

remap("n", "<leader>cc", "<cmd>NoNeckPain<cr>", { desc = "toggle no neck pain" })

return {
	"shortcuts/no-neck-pain.nvim",
}
