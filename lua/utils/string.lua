local M = {}

---@param str string
M.lines = function(str)
	return str:gmatch("([^\n]+)")
end

--- Converts a string from title or pascal case to snake case
--- @param str string
M.snake_case = function(str)
	local res = str:sub(2):gsub("%u", function(letter)
		return "_" .. letter:lower()
	end)
	return str:sub(1, 1):lower() .. res
end

--- Converts a string from title or pascal case to snake case
--- @param str string
M.pascal_case = function(str)
	local res = str:sub(2):gsub("_%l", function(letter)
		return letter:sub(2, 2):upper()
	end)
	return str:sub(1, 1) .. res
end

--- Turns snake into pascal case and pascal and title case into snake case
--- @param str string
M.toggle_case = function(str)
	if str:find("%u") then
		return M.snake_case(str)
	else
		return M.pascal_case(str)
	end
end

---@param str string
---@param mapper fun(strings): string
---@return string - result of mapping each line with mapper
M.map_lines = function(str, mapper)
	local lines = {}
	local idx = 1
	for line in M.lines(str) do
		lines[idx] = mapper(line)
		idx = idx + 1
	end
	return table.concat(lines, "\n")
end

return M
