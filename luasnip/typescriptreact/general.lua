local fs = require("utils.fs")

local snippets = {
	s(
		{ trig = ";co", snippetType = "autosnippet" },
		fmta(
			[[
    export default function <>() {
        return (<<div>>
            <>
        <</div>>);
    }
    ]],
			{ f(function()
				return vim.fn.fnamemodify(fs.cwf(), ":t:r")
			end), i(1) }
		)
	),
}

return snippets
