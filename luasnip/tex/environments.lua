local get_visual = require("utils.snippets").get_visual

local snippets = {
	s(
		{ trig = "env", desc = "begin general environment" },
		fmta(
			[[
                \begin{<>}
                <>
                \end{<>}
            ]],
			{ i(1), i(0), rep(1) }
		)
	),
	s(
		{ trig = "code", desc = "minted environment within figure" },
		fmta(
			[[
                \begin{minted}{<>}
                <>
                \end{minted}
            ]],
			{ i(1), i(0) }
		)
	),
	s(
		{ trig = "itemize", desc = "itemize list" },
		fmta(
			[[
                \begin{itemize}
                    \item <>
                \end{itemize}
            ]],
			{ i(0) }
		)
	),
	s(
		{ trig = "lquote", desc = "literal quote" },
		fmta(
			[[
                \begin{displayquote}
                <>
                \hfill\parencite{<>}
                \end{displayquote}
            ]],
			{ i(0), i(1, "source") }
		)
	),
}

local simple_envs = {
	"center",
	"figure",
	"listing",
	"table",
}

for _, env in ipairs(simple_envs) do
	local content = string.format(
		[[
            \begin{%s}
                <>
            \end{%s}
        ]],
		env,
		env
	)
	snippets[#snippets + 1] = s({ trig = env }, fmta(content, { d(1, get_visual) }))
end

return snippets
