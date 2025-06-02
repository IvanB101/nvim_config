local iter = {}

---@generic T, R
---@param iterable fun() : T?
---@param mapper fun(T) : R
iter.map = function(iterable, mapper)
	return function()
		local val = iterable()
		return val ~= nil and mapper(val) or nil
	end
end

---@generic T
---@param iterable fun() : T?
---@param filter fun(T) : boolean
iter.filter = function(iterable, filter)
	return function()
		local val = iterable()
		while val ~= nil and not filter(val) do
			val = iterable()
		end
		return val
	end
end

---@generic T
---@param iterable fun() : T?
---@param n integer
iter.skip = function(iterable, n)
	local skipped = false
	return function()
		if not skipped then
			for _ = 1, n do
				if iterable() == nil then
					return nil
				end
			end
			skipped = true
		end
		return iterable()
	end
end

---@generic T
---@param iterable fun() : T?
---@param separator string
iter.join = function(iterable, separator)
	local res = tostring(iterable()) or ""
	for val in iterable do
		res = res .. separator .. tostring(val)
	end
	return res
end

return iter
