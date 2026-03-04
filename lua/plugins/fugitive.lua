local remap = vim.keymap.set

local config = function()
	-- make diff operations vertical by default
	vim.cmd("set diffopt+=vertical")
	local select_conflict_marker = "?^<<<<<<<<CR> V ?^>>>>>>><CR>"
	remap("v", "m", "<Esc>" .. select_conflict_marker)
	remap("n", "<leader>dl", select_conflict_marker .. ":diffget //3<CR>")
	remap("n", "<leader>dh", select_conflict_marker .. ":diffget //2<CR>")
end

return {
	"tpope/vim-fugitive",
	keys = {
		{ "R", "<cmd>G fetch<cr>" },
		{ "<leader>gt", ":tab Git " },
		{ "<leader>gs", "<cmd>tab Git<cr>" },
		{ "<leader>gv", "<cmd>tab Gdiffsplit<cr>" },
	},
	config = config,
}
