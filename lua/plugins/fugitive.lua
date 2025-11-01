local remap = vim.keymap.set
local unmap = vim.keymap.del
local usercmd = vim.api.nvim_create_user_command

---@param lines string[]
local function diffget(lines, target)
	local row = vim.api.nvim_win_get_cursor(0)[1]

	local start = row
	while not lines[start]:find("^<<<<<<<") do
		start = start - 1
		if start < 1 then
			return
		end
	end
	local finish = row
	while not lines[finish]:find("^>>>>>>>") do
		finish = finish + 1
		if finish > #lines then
			return
		end
	end

	local cmd = string.format("%d,%d%s //%d", start, finish, "diffget", target)
	vim.cmd(cmd)
end

local config = function()
	-- make diff operations vertical by default
	vim.cmd("set diffopt+=vertical")

	usercmd("GitMergeResolve", function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		vim.cmd("Gvdiffsplit!")
		remap("n", "<A-h>", function()
			diffget(lines, 2)
		end, { desc = "select diff on target branch (left buffer)", buffer = true })
		remap("n", "<A-l>", function()
			diffget(lines, 3)
		end, { desc = "select diff on merge branch (right buffer)", buffer = true })
	end, { desc = "set buffers and mapping to resolve merge conflics" })

	usercmd("GitMergeResolveEnd", function()
		vim.cmd("only")
		unmap("n", "<A-h>", { buffer = true })
		unmap("n", "<A-l>", { buffer = true })
	end, { desc = "removes buffers and mapping to resolve merge conflics" })
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
