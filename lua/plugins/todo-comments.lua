local remap = vim.keymap.set

local keys = {
	g = false,
	t = { "TODO" },
	w = { "WARN", "WARNING", "XXX", "CHECK" },
}

for key, keywords in pairs(keys) do
	local desc = "Next todo comment"
	if keywords then
		desc = desc .. "(" .. table.concat(keywords, ", ") .. ")"
	end
	remap("n", "]" .. key, function()
		require("todo-comments").jump_next(keywords and { keywords = keywords } or nil)
	end, { desc = desc })
	remap("n", "[" .. key, function()
		require("todo-comments").jump_prev(keywords and { keywords = keywords } or nil)
	end, { desc = desc })
end

local opts = {
	FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
	TODO = { icon = " ", color = "info" },
	HACK = { icon = " ", color = "warning" },
	WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "CHECK" } },
	PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
	NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
	TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
}

return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup(opts)
	end,
}
