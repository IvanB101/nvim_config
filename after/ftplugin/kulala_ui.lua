vim.keymap.set("n", "<leader>L", function()
	vim.cmd("tab new")
	vim.bo.buftype = "nofile"
	vim.bo.ft = "json"
	vim.cmd("read /Users/ivan.brocas@feverup.com/.cache/nvim/kulala/body.txt")
	vim.cmd("normal! kdd")
end)
