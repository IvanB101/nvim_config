local str = require("utils.string")
local clipboard = ""
local to_move = false

local aux = require("utils.fs.aux")
local generate_unique_name = aux.generate_unique_name
local check_name_colisions = aux.check_name_colisions
local check_circular_reference = aux.check_circular_reference

local function refresh()
	vim.cmd("Ex")
end

---@alias Clipboard
---| 1 # FILES
---| 2 # SYSTEM
---@type table<string, Clipboard>
local Clipboard = {
	LOCAL = 1,
	SYSTEM = 2,
}

---@class Opts
---@field clipboard Clipboard

---@param opts ?Opts
---@param files string
local function copy(files, opts)
	opts = opts or { clipboard = Clipboard.LOCAL }
	if opts.clipboard == Clipboard.LOCAL then
		clipboard = files
	else
		-- TODO
		-- system cliboard
	end
	to_move = false
end

---@param files string
local function move(files)
	clipboard = files
	to_move = true
end

---@param opts? Opts
---@param dst string
local function paste(dst, opts)
	opts = opts or { clipboard = Clipboard.LOCAL }
	local clip = clipboard
	if opts.clipboard == Clipboard.SYSTEM then
		clip = ""
		for path in str.lines(vim.fn.getreg("+")) do
			local stat = vim.uv.fs_stat(path)
			if not stat then
				vim.notify("Only files can be pasted in this buffer", vim.log.levels.ERROR)
				return
			end
			clip = (clip and clip .. "\n" or "") .. path .. "/" .. (stat.type == "directory" and "/" or "")
		end
	end

	local circular = check_circular_reference(dst, clip)
	if circular then
		local action = to_move and "move" or "copy"
		vim.notify(
			"Cannot " .. action .. " directory (" .. circular .. ") into itself (" .. dst .. ")",
			vim.log.levels.ERROR
		)
		return
	end

	if to_move then
		local collision = check_name_colisions(dst, clip)
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
		goto after_paste
	end

	for path in str.lines(clip) do
		local final_name = generate_unique_name(dst, path)
		if vim.uv.fs_stat(path).type == "directory" then
			vim.uv.fs_mkdir(dst .. final_name, 493) -- rwxr-xr-x
			path = path:gsub(" ", "\\ ")
			final_name = final_name:gsub(" ", "\\ ")
			vim.cmd("silent !cp -r " .. path .. "* -t " .. dst:gsub(" ", "\\ ") .. final_name)
		else
			vim.uv.fs_copyfile(path, dst .. final_name)
		end
	end

	::after_paste::
	refresh()
end

---@class delete.Opts
---@field with_confirmation boolean

---@param files string
---@param opts? delete.Opts
local function delete(files, opts)
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
	refresh()
end

---return the directory currently displayed in netrw or the parent directory if viewing a file
---@return string
local function cwd()
	local dir = vim.fn.expand("%")
	if dir:sub(1, 1) == "/" then
		return dir .. "/"
	end
	dir = dir ~= "" and dir .. "/" or ""
	local root = vim.fn.getcwd() .. "/"
	return root .. dir
end

--- creates file, or directory if path ends with /
---@param path string
local function create(path)
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
	refresh()
end

--- opens path with OS default application for filetype
---@param path string
local function open(path)
	vim.cmd("!open " .. path)
end

---@return string
local function get_selected_files()
	vim.cmd("normal! y")
	return str.map_lines(vim.fn.getreg('"'), function(line)
		return cwd() .. line
	end)
end

---@return string
local function get_marked_files()
	local files = vim.fn["netrw#Expose"]("netrwmarkfilelist")
	if files == "n/a" then
		return ""
	end
	vim.cmd("normal U")
	return table.concat(files, "\n")
end

return {
	copy = copy,
	move = move,
	paste = paste,
	delete = delete,
	create = create,
	open = open,
	cwd = cwd,
	Clipboard = Clipboard,
	get_selected_files = get_selected_files,
	get_marked_files = get_marked_files,
}
