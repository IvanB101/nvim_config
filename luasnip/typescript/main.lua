local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local snippets = {
	s(
		{ trig = "type" },
		fmta(
			[[
                type <> = {
                    <>
                }
    ]],
			{ i(1), i(0) }
		)
	),
	s(
		{ trig = "extype" },
		fmta(
			[[
                export type <> = {
                    <>
                }
    ]],
			{ i(1), i(0) }
		)
	),
}

return snippets
