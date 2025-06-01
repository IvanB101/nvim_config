-- s({trig=";mint", snippetType="autosnippet"}

local get_visual = require("utils.snippets").get_visual

return {
	s(
		{ trig = ";be", desc = "begin general environment" },
		fmta(
			[[
                \begin{<>}
                    <>
                \end{<>}
            ]],
			{ i(1), i(2), rep(1) }
		)
	),
	s(
		{ trig = ";ce", snippetType = "autosnippet", dscr = "center block" },
		fmta(
			[[
                \begin{center}
                    <>
                \end{center}
            ]],
			{ d(1, get_visual) }
		)
	),
	s({ trig = ";ci", snippetType = "autosnippet", dscr = "citation" }, fmta([[\cite{<>}]], { i(1) })),
	s(
		{ trig = ";hr", snippetType = "autosnippet", dscr = "hyperref (for url links)" },
		fmta([[\href{<>}{<>}]], { i(1, "url"), i(2, "display name") })
	),
	s({ trig = ";pa", snippetType = "autosnippet", dscr = "citation" }, fmta([[\paragraph{<>}]], { i(1) })),
	s({ trig = ";v", snippetType = "autosnippet", desc = "verb" }, fmta([[ \verb|<>| ]], { d(1, get_visual) })),
}
