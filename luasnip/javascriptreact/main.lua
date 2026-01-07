local fs = require("utils.fs")

local ls = require("luasnip")
local s = ls.snippet_node
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
	s(
		{ trig = ";co", snippetType = "autosnippet" },
		fmta(
			[[
    export default function <>() {
        return (<<div>>
            <>
        <</div>>);
    }
    ]],
			{ f(function()
				return vim.fn.fnamemodify(fs.cwf(), ":t:r")
			end), i(1) }
		)
	),
	s({ trig = "Button" }, fmt("<button onClick={{{}}}>{}</button>", { i(1), i(0) })),
	s({ trig = "Link" }, fmt('<Link href="{}">{}</Link >', { i(1), i(0) })),
	s({ trig = "Label" }, fmt('<label htmlFor="{}">{}</label>', { i(1), i(2) })),
}

return snippets
