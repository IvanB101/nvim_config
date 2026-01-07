local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s({ trig = ";ty", desc = "typename arg", snippetType = "autosnippet", wordTrig = false }, t(", typename ")),
	s({ trig = ";te", desc = "template", snippetType = "autosnippet" }, t("template <typename T> ")),
	s(
		{ trig = ";tm", desc = "template with multiple args", snippetType = "autosnippet" },
		fmt([[template <typename {}> ]], { i(0) })
	),
}
