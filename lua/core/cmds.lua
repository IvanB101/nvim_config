local usercmd = vim.api.nvim_create_user_command
local fs = require("utils.fs")

usercmd("Cd", function()
	vim.fn.setreg("+", fs.cwd())
end, { desc = "show current working file" })
usercmd("Cp", function()
	local file = vim.fn.fnamemodify(fs.cwf(), ":t")
	vim.fn.setreg("+", file)
end, { desc = "show current working file path" })
usercmd("Cf", function()
	vim.fn.setreg("+", fs.cwd())
end, { desc = "show current working file" })

usercmd("Open", function()
	fs.open(fs.cwf())
end, { desc = "open current working file with default system app" })
usercmd("Delete", function()
	fs.delete(fs.cwf())
end, { desc = "delete current working file" })

usercmd("Messages", function()
	vim.cmd("tab new")
    vim.bo.buftype = "nofile"
	vim.cmd("put =execute('messages')")
end, { desc = "delete current working file" })
