local usercmd = vim.api.nvim_create_user_command
local fs = require("utils.fs")

usercmd("Cwd", function()
	vim.notify(fs.cwd(), vim.log.levels.INFO)
end, { desc = "show current working file" })

usercmd("Cwf", function()
	vim.notify(fs.cwf(), vim.log.levels.INFO)
end, { desc = "show current working file" })

usercmd("Cd", function()
    local dir = fs.cwd()
    vim.fn.setreg("+", dir)
end, { desc = "show current working file" })

usercmd("Cf", function()
    local file = vim.fn.fnamemodify(fs.cwf(), ":t")
    vim.fn.setreg("+", file)
end, { desc = "show current working file" })

usercmd("Open", function()
	fs.open(fs.cwf())
end, { desc = "open current working file with default system app" })

usercmd("Delete", function()
	fs.delete(fs.cwf())
end, { desc = "delete current working file" })

usercmd("Messages", function()
	vim.cmd("new | put =execute('messages')")
end, { desc = "delete current working file" })
