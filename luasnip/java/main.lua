local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

return {
	s(
		{ trig = "print", desc = "print value in vim clipboard" },
		f(function()
			local var = vim.fn.getreg("+")
			return string.format('System.out.println("%s: " + %s);', var, var)
		end, {})
	),
	-- TODO: DTO
	-- TODO: converter?
}
