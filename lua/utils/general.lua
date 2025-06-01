--- Converts a string from title or pascal case to snake case
--- @param str string
local function title_to_snake_case(str)
	local res = str:sub(2):gsub("%u", function(letter)
		return "_" .. letter:lower()
	end)
	return str:sub(1, 1):lower() .. res
end

--- Converts a string from title or pascal case to snake case
--- @param str string
local function snake_to_pascal_case(str)
	local res = str:sub(2):gsub("_%l", function(letter)
		return letter:sub(2, 2):upper()
	end)
	return str:sub(1, 1) .. res
end

--- Turns snake into pascal case and pascal and title case into snake case
--- @param str string
local function toggle_case(str)
	if str:find("%u") then
		return title_to_snake_case(str)
	else
		return snake_to_pascal_case(str)
	end
end

return {
	title_to_snake_case = title_to_snake_case,
	snake_to_pascal_case = snake_to_pascal_case,
	toggle_case = toggle_case,
}
