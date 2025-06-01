local user_cmd = vim.api.nvim_create_user_command

user_cmd("CleanSwap", function()
	vim.cmd("silent !rm ~/.local/state/nvim/swap/*")
end, { desc = "clean swap" })

vim.api.nvim_create_user_command("MarkSelectedFiles", function()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	for lnum = start_line, end_line do
		vim.fn.cursor(lnum, 1)
		vim.cmd("normal mf")
	end
end, { range = true })
