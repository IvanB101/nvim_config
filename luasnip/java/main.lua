local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s({ trig = "warn", desc = "todo comments" }, fmt("// WARN: {}", i(0))),
}
