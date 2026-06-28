local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta

return {
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
