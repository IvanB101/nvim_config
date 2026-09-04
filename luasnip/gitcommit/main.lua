local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		{ trig = ";me", desc = "onebox commit message", snippetType = "autosnippet" },
		fmt(
			[[
            {}{}

            {}
    ]],
			{
				f(function()
					local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
					local epic = vim.fn.system("ob epic"):gsub("\n", "")
					epic = epic and epic ~= "" and string.format(" (%s) ", epic) or " "
					return branch .. epic
				end, {}),
				i(1),
				t("Co-Authored-By: Claude <noreply@anthropic.com>"),
			}
		)
	),
}
