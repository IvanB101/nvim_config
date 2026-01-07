local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
	-- on delete
	s({ trig = "cascade" }, t([[ON DELETE CASCADE]])),
	s({ trig = "restrict" }, t([[ON DELETE RESTRICT]])),
	s({ trig = "setnull" }, t([[ON DELETE SET NULL]])),

	s(
		{ trig = "create" },
		fmt(
			[[
    CREATE TABLE {} (
        {}
    ) 
    ]],
			{ i(1), i(0) }
		)
	),
	s({ trig = "drop" }, fmt([[DROP TABLE {}]], { i(1) })),
	s({ trig = "dropif" }, fmt([[DROP TABLE IF EXISTS {}]], { i(1) })),
	s({ trig = "foreign_key" }, fmt([[FOREIGN KEY ({}) references {} ]], { i(1), i(2) })),
	s({ trig = "idauto" }, t([[id BIGSERIAL PRIMARY KEY]])),
	s({ trig = "notnull", snippetType = "autosnippet" }, t([[NOT NULL]])),
}

local key_words = {
	"alter",
	"delete",
	"drop",
	"from",
	"exists",
	"if",
	"update",
	"select",
	"table",
	"type",
	"where",
}

for _, word in ipairs(key_words) do
	snippets[#snippets + 1] = s({ trig = word }, t(string.upper(word) .. " "))
end

return snippets
