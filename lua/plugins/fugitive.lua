local config = function()
	local remap = vim.keymap.set
	remap("n", "<leader>gt", ":tab Git ", { desc = "Git status" })
	remap("n", "<leader>gs", "<cmd>tab Git<cr>", { desc = "Git status" })
	remap("n", "<leader>gv", "<cmd>tab Gdiffsplit<cr>", { desc = "Git diffsplit (with HEAD)" })
	-- diff operations are vertical by default
	vim.cmd("set diffopt+=vertical")
end

return {
	"tpope/vim-fugitive",
	config = config,
}
