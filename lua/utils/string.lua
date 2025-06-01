---@param str string
local function lines(str)
	return str:gmatch("([^\n]+)")
end

---@param str string
---@param postfix string
---@return string
local function line_append(str, postfix)
	local res = ""
	for line in lines(str) do
		res = res .. line .. postfix .. "\n"
	end
	return res
end

---@param str string
---@param prefix string
---@return string
local function line_preppend(str, prefix)
	local res = ""
	for line in lines(str) do
		res = res .. prefix .. line .. "\n"
	end
	return res
end

return {
	lines = lines,
	line_append = line_append,
	line_preppend = line_preppend,
}
