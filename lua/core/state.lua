--- @class State
--- @field root_dir string?
local inner = {}

local expose = {}
setmetatable(expose, {
	__index = inner,
	__newindex = function(_, key, _)
		error("Attempt to modify read-only table: state." .. key, 2)
	end,
})

local state = {}

---@param props State
state.update = function(props)
	for key, val in pairs(props) do
		inner[key] = val
	end
end

---@return State
state.get = function()
	return expose
end

return state
