local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local snippets = {
	s(
		{ trig = "link" },
		fmta([[[<>](<>)]], { i(1), f(function()
			return vim.fn.getreg("+")
		end) })
	),
	s(
		{ trig = "json" },
		fmta(
			[[
        ```json
        <>
        ```
        ]],
			{ i(1) }
		)
	),
}

return snippets
