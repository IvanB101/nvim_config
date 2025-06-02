local iter = require("utils.iter")
local string = {}

---@param str string
string.lines = function(str)
	return str:gmatch("([^\n]+)")
end

--- Converts a string from title or pascal case to snake case
--- @param str string
string.snake_case = function(str)
	local res = str:sub(2):gsub("%u", function(letter)
		return "_" .. letter:lower()
	end)
	return str:sub(1, 1):lower() .. res
end

--- Converts a string from title or pascal case to snake case
--- @param str string
string.pascal_case = function(str)
	local res = str:sub(2):gsub("_%l", function(letter)
		return letter:sub(2, 2):upper()
	end)
	return str:sub(1, 1) .. res
end

--- Turns snake into pascal case and pascal and title case into snake case
--- @param str string
string.toggle_case = function(str)
	if str:find("%u") then
		return string.snake_case(str)
	else
		return string.pascal_case(str)
	end
end

---@param str string
---@param mapper fun(strings): string
---@return string - result of mapping each line with mapper
string.map_lines = function(str, mapper)
	return iter.join(iter.map(string.lines(str), mapper), "\n")
end

return string
