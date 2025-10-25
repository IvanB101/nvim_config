local snippets = {
	s(
		{ trig = "try" },
		fmta(
			[[
            try {
                <>
            } catch(e) {
                <>
            }
    ]],
			{ i(1), i(0) }
		)
	),
}

return snippets
