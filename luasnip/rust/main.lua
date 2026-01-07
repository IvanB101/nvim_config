local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

local snippets = {
	s(
		{ trig = "tests" },
		fmta(
			[[
            #[cfg(test)]
            pub mod tests {
                use super::*;

                #[test]
                fn basics() {
                    <>
                }
            }
    ]],
			{ i(1) }
		)
	),
	s(
		{ trig = "test" },
		fmta(
			[[
                #[test]
                fn <>() {
                    <>
                }
    ]],
			{ i(1), i(0) }
		)
	),
}

return snippets
