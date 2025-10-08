return {
	s({
		trig = "cmd",
		wordTrig = false,
		desc = "<cmd><cr>",
	}, fmt("<cmd>{}<cr>", i(0))),
	s({ trig = ";to", snippetType = "autosnippet", wordTrig = false }, t("-- TODO: ")),
}
