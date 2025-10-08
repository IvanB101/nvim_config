local snippets = {
	s(
		{ trig = "for" },
		fmta(
			[[
    for(var <> = 0; <> << <>; <>++) {
        <>
    }
    ]],
			{ i(1), rep(1), i(2), rep(1), i(0) }
		)
	),
	s({ trig = ";to", snippetType = "autosnippet", wordTrig = false }, t("// TODO: ")),
}

return snippets
