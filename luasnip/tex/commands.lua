return {
	s({ trig = "caption" }, fmta([[\caption{<>}]], { i(1) })),
	s({ trig = "cite" }, fmta([[\cite{<>}]], { i(1) })),
	s({ trig = "code" }, fmta([[\code{<>}]], { i(1) })),
	s({ trig = "image" }, fmta([[\includegraphics{<>}]], { i(1) })),
	s({ trig = "link", dscr = "link (hyperref)" }, fmta([[\href{<>}{<>}]], { i(1, "url"), i(2, "display name") })),
	s({ trig = "paragraph" }, fmta([[\paragraph{<>}]], { i(1) })),
	s({ trig = "section" }, fmta([[\section{<>}]], { i(1) })),
	s({ trig = "subsection" }, fmta([[\subsection{<>}]], { i(1) })),
}
