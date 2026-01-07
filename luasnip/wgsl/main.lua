local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta

local snippets = {
	s(
		{ trig = "for" },
		fmta(
			[[
    for(var <> = 0; <> << <>; <>++) {
        <>
    }
    ]],
			{ i(1), rep(1), i(2), rep(1), i(0) }
		)
	),
}

return snippets
