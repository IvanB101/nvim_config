local snippets = {}

local letters = {
	a = "alpha",
	b = "beta",
	d = "delta",
	e = "epsilon",
	g = "gamma",
	h = "eta",
	m = "mu",
	o = "omega",
	p = "pi",
	r = "rho",
	s = "sigma",
	t = "tau",
}

for key, letter in pairs(letters) do
	snippets[#snippets + 1] = s({ trig = "," .. key, snippetType = "autosnippet" }, { t("\\" .. letter) })
	snippets[#snippets + 1] = s(
		{ trig = "," .. string.upper(key), snippetType = "autosnippet" },
		{ t("\\" .. string.upper(string.sub(letter, 0, 1)) .. string.sub(letter, 2)) }
	)
end

return snippets
