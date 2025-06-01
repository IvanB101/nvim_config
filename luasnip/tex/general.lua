return {
	s({ trig = "img", desc = "image" }, fmta([[ \includegraphics{<>} ]], { i(1) })),
	s(
		{ trig = "mint", desc = "minted environment" },
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
