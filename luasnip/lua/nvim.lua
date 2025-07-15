return {
	s({
		trig = "cmd",
		wordTrig = false,
		desc = "<cmd><cr>",
	}, fmt("<cmd>{}<cr>", i(0))),
	s({
		trig = "todo",
		wordTrig = false,
		desc = "TODO",
	}, fmt("-- TODO: {}", i(0))),
}
