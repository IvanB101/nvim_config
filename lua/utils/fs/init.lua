local str = require("utils.string")
local clipboard = ""
local to_move = false

local aux = require("utils.fs.aux")

local M = {}

M.refresh = function()
	vim.cmd("Ex")
end

---@alias Clipboard
---| 1 # FILES
---| 2 # SYSTEM
---@type table<string, Clipboard>
M.Clipboard = {
	LOCAL = 1,
	SYSTEM = 2,
}

---@class Opts
---@field clipboard Clipboard

---@param opts ?Opts
---@param files string
M.copy = function(files, opts)
	opts = opts or { clipboard = M.Clipboard.LOCAL }
	if opts.clipboard == M.Clipboard.LOCAL then
		clipboard = files
	else
		-- TODO: system cliboard
	end
	to_move = false
end

---@param files string
M.move = function(files)
	clipboard = files
	to_move = true
end

---@param opts? Opts
---@param dst string
M.paste = function(dst, opts)
	opts = opts or { clipboard = M.Clipboard.LOCAL }
	local clip = clipboard
	if opts.clipboard == M.Clipboard.SYSTEM then
		clip = ""
		for path in str.lines(vim.fn.getreg("+")) do
			local stat = vim.uv.fs_stat(path)
			if not stat then
				vim.notify("Only files can be pasted in this buffer", vim.log.levels.ERROR)
				return
			end
			clip = (clip and clip .. "\n" or "") .. path .. (stat.type == "directory" and "/" or "")
		end
	end

	local circular = aux.check_circular_reference(dst, clip)
	if circular then
		local action = to_move and "move" or "copy"
		vim.notify(
			"Cannot " .. action .. " directory (" .. circular .. ") into itself (" .. dst .. ")",
			vim.log.levels.ERROR
		)
		return
	end

	if to_move then
		local collision = aux.check_name_colisions(dst, clip)
		if collision then
			vim.notify("Dst already has a " .. collision.type .. " named " .. collision.name)
			return
		end

		for path in str.lines(clip) do
			local name
			if vim.uv.fs_stat(path).type == "directory" then
				name = vim.fn.fnamemodify(path, ":h:t")
			else
				name = vim.fn.fnamemodify(path, ":t")
			end
			vim.uv.fs_rename(path, dst .. name)
		end
		to_move = false
		goto refresh
	end

	for path in str.lines(clip) do
		local final_name = aux.generate_unique_name(dst, path)
		if vim.uv.fs_stat(path).type == "directory" then
			vim.uv.fs_mkdir(dst .. final_name, 493) -- rwxr-xr-x
			path = path:gsub(" ", "\\ ")
			final_name = final_name:gsub(" ", "\\ ")
			vim.cmd("silent !cp -r " .. path .. "* -t " .. dst:gsub(" ", "\\ ") .. final_name)
		else
			vim.uv.fs_copyfile(path, dst .. final_name)
		end
	end

	::refresh::
	M.refresh()
end

---@class delete.Opts
---@field with_confirmation boolean

---@param files string
---@param opts? delete.Opts
M.delete = function(files, opts)
	opts = opts or { with_confirmation = true }
	local n_files = 0
	for _ in str.lines(files) do
		n_files = n_files + 1
	end
	if opts.with_confirmation then
		if n_files > 1 then
			local confirm = vim.fn.input("Deleting files:\n" .. files .. "confirm [y/N]: ")
			if confirm ~= "y" then
				return
			end
		else
			local file = select(1, str.lines(files))()
			vim.api.nvim_echo({ { "Confirm deletion of: " .. file .. " [y/n]: ", "Error" } }, false, {})
			if vim.fn.getchar(-1, { number = false }) ~= "y" then
				return
			end
		end
	end
	for file in str.lines(files) do
		vim.fn.delete(file:gsub("*$", ""), "rf")
	end
	M.refresh()
end

---return the currect working file, if editing one, or directory, if in netrw buffer
---@return string
M.cwf = function()
	local file = vim.fn.expand("%")
	local is_absolute = file:sub(1, 1) == "/"

	if not is_absolute then
		local root = vim.fn.getcwd()
		file = root .. (file and "/" .. file or "")
	end
	if vim.uv.fs_stat(file).type == "directory" then
		file = file .. "/"
	end

	return file
end

---return the current working directory
---@return string
M.cwd = function()
	local dir = M.cwf()

	if not dir:match("/$") then
		dir = vim.fn.fnamemodify(dir, ":h") .. "/"
	end

	return dir
end

--- creates file, or directory if path ends with /
---@param path string
M.create = function(path)
	local is_dir = path:find("/$")
	if vim.uv.fs_stat(path) then
		local type = is_dir and "directory" or "file"
		vim.notify(path .. " " .. type .. " already exists", vim.log.levels.ERROR)
		return
	end
	if is_dir then
		vim.system({ "mkdir", path })
	else
		vim.system({ "touch", path })
	end
	M.refresh()
end

--- opens path with OS default application for filetype
---@param path string
M.open = function(path)
	vim.cmd("!open " .. '"' .. path:gsub("%*$", "") .. '"')
end

M.debug = function()
	print(clipboard)
end

return M
