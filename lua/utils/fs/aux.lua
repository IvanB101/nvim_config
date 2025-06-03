local str = require("utils.string")

-- src dir/
-- dst dir/inner/
-- file /some/path/inner
-- dst /some/
--

---@param dst string
---@param files string
---@return string?
local function check_circular_reference(dst, files)
	for file in str.lines(files) do
		if vim.uv.fs_stat(file).type == "directory" and dst:find(file) then
			return file
		end
	end
	return nil
end

---@class Item
---@field name string
---@field type string

---@param dst string
---@param files string
---@return Item?
local function check_name_colisions(dst, files)
	dst = dst:gsub("/$", "")
	local in_dst = {}
	for name, type in vim.fs.dir(dst) do
		in_dst[#in_dst + 1] = {
			name = name:gsub("/$", ""),
			type = type,
		}
	end
	for file in str.lines(files) do
		file = file:gsub("/$", "")
		for _, item in ipairs(in_dst) do
			if file == item.name then
				return item
			end
		end
	end
	return nil
end

---@param dir string
---@param path string
---@return string
local function generate_unique_name(dir, path)
	local stat = vim.uv.fs_stat(path) or error("no such file or directory: " .. path, vim.log.levels.ERROR)
	local is_dir = stat.type == "directory"

	if is_dir then
		local name = vim.fn.fnamemodify(path, ":h:t")
		local final_name = name

		local repeated = vim.uv.fs_stat(dir .. final_name) ~= nil
		if repeated then
			final_name = name .. " copy/"
		end
		local copies = 1
		while vim.uv.fs_stat(dir .. final_name) ~= nil do
			copies = copies + 1
			final_name = name .. " copy " .. tostring(copies) .. "/"
		end

		return final_name
	else
		local name = vim.fn.fnamemodify(path, ":t:r")
		local ext = vim.fn.fnamemodify(path, ":e")

		local final_name = name .. (ext and "." .. ext or "")
		local repeated = vim.uv.fs_stat(dir .. final_name) ~= nil
		if repeated then
			final_name = name .. " copy" .. (ext and "." .. ext or "")
		end
		local copies = 1
		while vim.uv.fs_stat(dir .. final_name) ~= nil do
			copies = copies + 1
			final_name = name .. " copy " .. tostring(copies) .. (ext and "." .. ext or "")
		end

		return final_name
	end
end

return {
	generate_unique_name = generate_unique_name,
	check_circular_reference = check_circular_reference,
	check_name_colisions = check_name_colisions,
}
