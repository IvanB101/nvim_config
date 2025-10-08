local fs = require("utils.fs")
local editor = require("utils.editor")

---@return string
local function get_selected_files()
	local lines = editor.get_selected_lines()
	for i, line in ipairs(lines) do
		lines[i] = fs.cwd() .. line
	end
	return vim.fn.join(lines, "\n")
end

vim.api.nvim_set_hl(0, "Copying", { bg = "#ff0000", fg = "#fabd2f", bold = true })
vim.api.nvim_set_hl(0, "Moving", { bg = "#00ff00", fg = "#fabd2f", bold = true })

local function load_mappings()
	local remap = vim.keymap.set
	local bind = function(lhs, rhs, desc)
		remap("n", lhs, rhs, { buffer = true, desc = desc, remap = true })
	end

	bind("a", "<nop>", "no showing only hidden files")
	bind("s", "<nop>", "no sort changin")
	bind("i", "<nop>", "single dir buf preferred")
	bind("o", "<nop>", "why would I open somethin in a horizontal split")
	remap("n", "v", "v", { buffer = true, remap = false, desc = "idem 'o' (but vertical)" })

	bind("d", function()
		fs.debug()
	end)

	remap("v", "c", function()
		fs.copy(get_selected_files())
	end, { desc = "copy selected files", buffer = true })
	remap("v", "x", function()
		fs.move(get_selected_files())
	end, { desc = "move selected files", buffer = true })
	remap("v", "D", function()
		fs.delete(get_selected_files())
	end, { desc = "delete selected files", buffer = true })

	bind("p", function()
		fs.paste(fs.cwd())
	end, "paste selected files")
	bind("<leader>p", function()
		fs.paste(fs.cwd(), { clipboard = fs.Clipboard.SYSTEM })
	end, "paste selected files")

	bind("O", function()
		local file = vim.fn.getline(".")
		fs.open(fs.cwd() .. file)
	end, "open file under cursor")

	bind("r", "R", "rename")
	remap("n", "a", function()
		local name = vim.fn.input("Please enter file (end with '/' for directory) name: ")
		if name == "" then
			return
		end
		fs.create(fs.cwd() .. name)
	end, { desc = "create new file or directory", buffer = true })
	remap("n", "A", function()
		local name = vim.fn.input("Please enter file (end with '/' for directory) name: ")
		if name == "" then
			return
		end
		local path = fs.cwd() .. name
		fs.create(path)
		vim.cmd("edit " .. path)
	end, { desc = "create new file or directory and edit", buffer = true })

	bind("h", "-", "go to parent directory")
	bind("l", "<cr>", "go to directory or open file")

	bind("<f1>", "<cmd>tab help netrw<cr>", "netrw help")
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.opt.relativenumber = true
		load_mappings()
	end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufWritePost" }, {
	pattern = "netrw",
	callback = function()
		-- TODO: highlinhts
	end,
})
