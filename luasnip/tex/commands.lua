local get_visual = require("utils.snippets").get_visual

local snippets = {
	s({ trig = "image" }, fmta([[\includegraphics{<>}]], { i(1) })),
	s({ trig = "link", dscr = "link (hyperref)" }, fmta([[\href{<>}{<>}]], { i(2, "url"), d(1, get_visual) })),
}

-- TODO: make snippets based on alias and number of args

local aliases = {
	{ "as", "acrshort" },
	{ "al", "acrlong" },
	{ "af", "acrfull" },
	{ "cr", "cref" },
	{ "sec", "section" },
	{ "ssec", "subsection" },
	{ "sssec", "subsubsection" },
}

local simple_cmds = {
	"caption",
	"cite",
	"code",
	"paragraph",
}

for _, alias in ipairs(aliases) do
	local content = string.format([[\%s{<>}]], alias[2])
	snippets[#snippets + 1] = s({ trig = alias[1] }, fmta(content, { i(1) }))
end

for _, cmd in ipairs(simple_cmds) do
	local content = string.format([[\%s{<>}]], cmd)
	snippets[#snippets + 1] = s({ trig = cmd }, fmta(content, { i(1) }))
end

return snippets
