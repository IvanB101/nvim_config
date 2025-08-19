local M = {}

---@generic T
---@class Iterator<T>
---@field _f fun(): ...
local iter_mt = {}

---@generic T, R
---@param mapper fun(...) : ...
---@return Iterator<R>
function iter_mt:map(mapper)
	local fn = self._f
	self._f = function()
		return (function(...)
			local var = ...
			if var == nil then
				return nil
			end
			return mapper(...)
		end)(fn())
	end
	return self
end

---@generic T, R
---@param predicate fun(...) : boolean
---@return Iterator<T>
function iter_mt:filter(predicate)
	local fn = self._f
	self._f = function()
		local ret = table.pack(fn())
		while ret[1] ~= nil and not predicate(table.unpack(ret)) do
			ret = table.pack(fn())
		end
		return table.unpack(ret)
	end
	return self
end

---@generic T
---@param n integer
---@return Iterator<T>
function iter_mt:skip(n)
	local fn = self._f
	local skipped = false
	self._f = function()
		if not skipped then
			for _ = 1, n do
				if fn() == nil then
					return nil
				end
			end
			skipped = true
		end
		return fn()
	end
	return self
end

---@generic T
---@return table<integer, T>
function iter_mt:collect()
	local values = {}
	local ret = self._f()
	while ret ~= nil do
		values[#values + 1] = ret
		ret = self._f()
	end
	return values
end

---@generic T
---@param separator string
function iter_mt:join(separator)
	return table.concat(self:collect(), separator)
end

---@generic T
---@return fun(): T?
function iter_mt:iter()
	return self._f
end

---@generic T, S, R
---@param _f fun(S, T): R?
---@param _s S?
---@param _var T?
---@return Iterator<T>
M.wrap = function(_f, _s, _var)
	local fn = function()
		return (function(...)
			local var = ...
			_var = var
			return ...
		end)(_f(_s, _var))
	end
	local wrapper = {
		_f = fn,
	}
	setmetatable(wrapper, { __index = iter_mt })
	return wrapper
end

return M
