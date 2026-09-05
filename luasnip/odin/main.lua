local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta
local f = ls.function_node

local snippets = {
	s({
		trig = "v(%d)",
		wordTrig = false,
		regTrig = true,
	}, { f(function(_, parent)
		return "[" .. parent.snippet.captures[1] .. "]f32"
	end) }),
	s(
		{ trig = "test", desc = "print value in vim clipboard" },
		fmta(
			[[
        @(test)
        <> :: proc(t: ^testing.T) {
            <>
        }
        ]],
			{ i(1), i(0) }
		)
	),
}

return snippets
