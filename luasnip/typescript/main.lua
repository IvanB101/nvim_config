return {
	s({ trig = ";to", snippetType = "autosnippet", wordTrig = false }, t("// TODO: ")),
	s({ trig = "warn", desc = "todo comments" }, fmt("// WARN: {}", i(0))),
}
