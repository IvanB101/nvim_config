local snippets = {}

local letters = {
	a = "á",
	e = "é",
	i = "í",
	o = "ó",
	u = "ú",
	n = "ñ",
	A = "Á",
	E = "É",
	I = "Í",
	O = "Ó",
	U = "Ú",
	N = "Ñ",
}

for key, letter in pairs(letters) do
	table.insert(snippets, s({ trig = ";" .. key, snippetType = "autosnippet", wordTrig = false }, { t(letter) }))
end

return snippets
