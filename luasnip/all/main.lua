local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local sn = ls.snippet_node
local d = ls.dynamic_node

local snippets = {}

local special_comments = {
	"error",
	"fix",
	"hack",
	"note",
	"perf",
	"test",
	"todo",
	"warn",
}

for _, tag in ipairs(special_comments) do
	snippets[#snippets + 1] = s(
		{ trig = tag },
		d(1, function(_, parent)
			local env = parent.snippet.env
			return sn(nil, fmt(env.LINE_COMMENT ..  " " .. tag:upper() .. ": {}", i(0)))
		end, {})
	)
end

local letters = {
	a = "á",
	e = "é",
	i = "í",
	o = "ó",
	u = "ú",
	n = "ñ",
	A = "Á",
	E = "É",
	I = "Í",
	O = "Ó",
	U = "Ú",

	N = "Ñ",

	du = "ü",

	f = "\\", -- comments in scheme require ;; :|
}

for key, letter in pairs(letters) do
	snippets[#snippets + 1] = s({ trig = ";" .. key, snippetType = "autosnippet", wordTrig = false }, { t(letter) })
end

return snippets
