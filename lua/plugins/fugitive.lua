local remap = vim.keymap.set
local usercmd = vim.api.nvim_create_user_command

local function accept_both()
	local buf = vim.api.nvim_get_current_buf()
	local view = vim.fn.winsaveview()

	local start = vim.fn.search([[^<<<<<<<]], "bcnW")
	if start == 0 then
		start = vim.fn.search([[^<<<<<<<]], "cnW")
	end
	if start == 0 then
		return
	end

	vim.api.nvim_win_set_cursor(0, { start, 0 })
	local finish = vim.fn.search([[^>>>>>>>]], "cnW")
	if finish == 0 then
		vim.fn.winrestview(view)
		return
	end

	local mid = vim.fn.search([[^=======]], "cnW", finish) -- stopline!
	local base = vim.fn.search([[^|||||||]], "cnW", mid) -- 0 if merge style

	-- delete bottom-up so upper line numbers stay valid
	vim.api.nvim_buf_set_lines(buf, finish - 1, finish, false, {})
	local upper_end = base > 0 and base or mid
	vim.api.nvim_buf_set_lines(buf, upper_end - 1, mid, false, {})
	vim.api.nvim_buf_set_lines(buf, start - 1, start, false, {})

	vim.fn.winrestview(view)
end

local config = function()
	vim.cmd("set diffopt+=vertical") -- make diff operations vertical by default
	local select_conflict_marker = "?^<<<<<<<<CR> V /^>>>>>>><CR>"
	remap("n", "<leader>L", select_conflict_marker .. ":diffget //3<CR>")
	remap("n", "<leader>H", select_conflict_marker .. ":diffget //2<CR>")
	remap("n", "<leader>B", accept_both)

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
		{ "<leader>gb", "<cmd>Git blame<cr>" },
	},
	config = config,
}
