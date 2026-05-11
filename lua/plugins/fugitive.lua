local remap = vim.keymap.set
local usercmd = vim.api.nvim_create_user_command

local config = function()
	vim.cmd("set diffopt+=vertical") -- make diff operations vertical by default
	local select_conflict_marker = "?^<<<<<<<<CR> V ?^>>>>>>><CR>"
	remap("v", "m", "<Esc>" .. select_conflict_marker)
	remap("n", "<leader>L", select_conflict_marker .. ":diffget //3<CR>")
	remap("n", "<leader>H", select_conflict_marker .. ":diffget //2<CR>")

	usercmd("Diff", function(args)
		vim.cmd("Gdiffsplit " .. args.args)
	end, { desc = "delete current working file" })
end

return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gt", ":tab Git " },
		{ "<leader>gs", "<cmd>tab Git<cr>" },
		{ "<leader>gv", "<cmd>tab Gdiffsplit<cr>" },
	},
	config = config,
}
