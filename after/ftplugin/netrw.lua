local remap = vim.keymap.set
local fs = require("utils.fs")

local bind = function(lhs, rhs, desc)
	remap("n", lhs, rhs, { buffer = true, desc = desc, remap = true })
end

vim.opt.relativenumber = true

bind("a", "<nop>", "no showing only hidden files")
bind("s", "<nop>", "no sort changin")
bind("i", "<nop>", "single dir buf preferred")
bind("v", "V", "quality of life")

remap("v", "y", function()
	fs.copy(fs.get_selected_files())
end, { desc = "copy selected files", buffer = true })
remap("v", "d", function()
	fs.move(fs.get_selected_files())
end, { desc = "move selected files", buffer = true })
remap("v", "D", function()
	fs.delete(fs.get_selected_files())
end, { desc = "delete selected files", buffer = true })

remap("n", "y", function()
	fs.copy(fs.get_marked_files())
end, { desc = "copy marked files", buffer = true })
remap("n", "d", function()
	fs.move(fs.get_marked_files())
end, { desc = "move marked files", buffer = true })
remap("n", "D", function()
	local files = fs.get_marked_files()
	if files == "" then
		fs.delete(fs.cwd() .. vim.api.nvim_get_current_line())
	else
		fs.delete(files)
	end
end, { desc = "delete marked files", buffer = true })

bind("p", function()
	fs.paste(fs.cwd())
end, "paste selected files")
bind("<leader>p", function()
	fs.paste(fs.cwd(), { clipboard = fs.Clipboard.SYSTEM })
end, "paste selected files")

bind("O", "t", "open in file new tab")
bind("o", function()
	local file = vim.fn.getline(".")
	fs.open(fs.cwd() .. file)
end, "open file under cursor")

bind("r", "R", "rename")
remap("n", "n", function()
	local name = vim.fn.input("Please enter file (end with '/' for directory) name: ")
	if name == "" then
		return
	end
	fs.create(fs.cwd() .. name)
end, { desc = "create new file or directory", buffer = true })
remap("n", "N", function()
	local name = vim.fn.input("Please enter file (end with '/' for directory) name: ")
	if name == "" then
		return
	end
	local path = fs.cwd() .. name
	fs.create(path)
	vim.cmd("edit " .. path)
end, { desc = "create new file or directory", buffer = true })

bind("h", "-", "go to parent directory")
bind("l", "<cr>", "go to directory or open file")

bind("<f1>", "<cmd>tab help netrw<cr>", "go to directory or open file")

bind("u", "mF", "unmark all files in current dir")
bind("U", "mu", "unmark all files")

remap("v", "mf", ":<C-U>MarkSelectedFiles<cr>", { buffer = true, desc = "mark selected files" })
