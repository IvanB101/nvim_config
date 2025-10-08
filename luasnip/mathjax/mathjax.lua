local letters = {
	a = "alpha",
	b = "beta",
	d = "delta",
	e = "epsilon",
	g = "gamma",
	h = "eta",
	m = "mu",
	n = "nabla",
	o = "omega",
	p = "pi",
	r = "rho",
	s = "sigma",
	th = "theta",
	ta = "tau",
}

local snippets = {
	s({ trig = ";bb", snippetType = "autosnippet", wordTrig = false }, fmta([[\mathbb{<>}]], { i(1) })),
	s({ trig = ";bf", snippetType = "autosnippet", wordTrig = false }, fmta([[\mathbf{<>}]], { i(1) })),
	s({ trig = ";f", snippetType = "autosnippet", wordTrig = false }, fmta([[\frac{<>}{<>}]], { i(1), i(2) })),
	s({ trig = ";l", snippetType = "autosnippet", wordTrig = false }, t([[\left]], { i(1), i(2) })),
	s({ trig = ";v", snippetType = "autosnippet", wordTrig = false }, fmta([[\vec{<>}]], { i(1) })),
	s({ trig = ";r", snippetType = "autosnippet", wordTrig = false }, t([[\right]], { i(1), i(2) })),
	s({ trig = ";s", snippetType = "autosnippet", wordTrig = false }, fmta([[\sqrt{<>}]], { i(1) })),
	s({ trig = ";t", snippetType = "autosnippet", wordTrig = false }, fmta([[\text{<>}]], { i(1) })),
	s({ trig = ";p", snippetType = "autosnippet", wordTrig = false }, fmta([[\left\(<>\right\)]], { i(1) })),

	s(
		{ trig = "begin" },
		fmta(
			[[
        \begin{<>}
            <>
        \end{<>}
    ]],
			{ i(1), i(0), rep(1) }
		)
	),
	s({ trig = "floor" }, fmta([[ \lfloor <>\rfloor ]], { i(1) })),
	s({ trig = "norm" }, fmta([[ \left\|<>\right\|]], { i(1) })),
	s({ trig = "choose" }, fmta([[ {<>\choose <>} ]], { i(1), i(2) })),
	s({ trig = "conjugate" }, fmta([[ \overline{<>} ]], { i(1) })),
}

for key, letter in pairs(letters) do
	snippets[#snippets + 1] = s({ trig = "," .. key, snippetType = "autosnippet" }, { t("\\" .. letter) })
	snippets[#snippets + 1] = s(
		{ trig = "," .. string.upper(key), snippetType = "autosnippet" },
		{ t("\\" .. string.upper(string.sub(letter, 0, 1)) .. string.sub(letter, 2)) }
	)
end

return snippets
