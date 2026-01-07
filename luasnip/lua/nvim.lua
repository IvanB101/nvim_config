local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
	s({
		trig = "cmd",
		wordTrig = false,
		desc = "<cmd><cr>",
	}, fmt("<cmd>{}<cr>", i(0))),
	s(
		{ trig = "init_snip" },
		fmta(
			[[
            local ls = require("luasnip")
            local s = ls.snippet

            local snippets = {
                <>
            }

            return snippets
    ]],
			i(0)
		)
	),
}

local nodes = {
	d = "ls.dynamic_node",
	i = "ls.insert_node",
	t = "ls.text_node",
	rep = 'require("luasnip.extras").rep',
	sn = "ls.snippet_node",
	fmt = 'require("luasnip.extras.fmt").fmt',
	fmta = 'require("luasnip.extras.fmt").fmta',
}

for node, content in pairs(nodes) do
	snippets[#snippets + 1] = s({ trig = "i" .. node }, t("local " .. node .. " = " .. content))
end

return snippets
