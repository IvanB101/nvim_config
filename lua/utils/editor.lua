local M = {}

--- replaces word under the cursor with string returned of rep_fun
--- @param rep_fun fun(string): string
M.replace_word_under_cursor = function(rep_fun)
	local word = vim.fn.expand("<cword>")
	local new_word = rep_fun(word)
	vim.cmd(string.format("normal! ciw%s", new_word))
end

return M
