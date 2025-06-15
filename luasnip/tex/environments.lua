local get_visual = require("utils.snippets").get_visual

return {
	s(
		{ trig = "env", desc = "begin general environment" },
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
		{ trig = "center", dscr = "center block" },
		fmta(
			[[
                \begin{center}
                    <>
                \end{center}
            ]],
			{ d(1, get_visual) }
		)
	),
	s(
		{ trig = "code", desc = "minted environment within figure" },
		fmta(
			[[
                \begin{minted}{<>}
                    <>
                \end{minted}
            ]],
			{ i(1), i(0) }
		)
	),
}
