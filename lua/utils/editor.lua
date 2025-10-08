local M = {}

--- replaces word under the cursor with string returned of rep_fun
--- @param rep_fun fun(string): string
M.replace_word_under_cursor = function(rep_fun)
	local word = vim.fn.expand("<cword>")
	local new_word = rep_fun(word)
	vim.cmd(string.format("normal! ciw%s", new_word))
end

--- visual mode (uses last selected range otherwise)
--- returns the lines in the selected range
--- even when not in line visual mode it returns the complete lines
---@return string[]
M.get_selected_lines = function()
	assert(vim.fn.mode() == "v" or vim.fn.mode() == "V", "get_selected_lines should only be called in visual mode")

	vim.cmd("normal! :<C-u><cr>")
	local _, ls = unpack(vim.fn.getpos("'<"))
	local _, le = unpack(vim.fn.getpos("'>"))

	ls, le = ls - 1, le - 1
	return vim.api.nvim_buf_get_lines(0, ls, le + 1, false)
end

return M
