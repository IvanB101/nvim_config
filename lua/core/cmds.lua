local usercmd = vim.api.nvim_create_user_command
local fs = require("utils.fs")

usercmd("Cwd", function()
	vim.notify(fs.cwd(), vim.log.levels.INFO)
end, { desc = "show current working file" })

usercmd("Cwf", function()
	vim.notify(fs.cwf(), vim.log.levels.INFO)
end, { desc = "show current working file" })
