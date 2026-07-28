local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

local function footer()
    -- TODO: footer
    return ""
end

return {
	s({ trig = ";me", desc = "onebox commit message", snippetType = "autosnippet" }, {
		f(function()
			local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
			local epic = require("vars").epic
			epic = epic and string.format(" (%s) ", epic) or ""
			return branch .. epic
		end, {}),
		i(1),
		f(footer, {}),
	}),
	s({ trig = ";mn", desc = "onebox commit message", snippetType = "autosnippet" }, {
		f(function()
			local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
			return branch
		end, {}),
		i(1),
		f(footer, {}),
	}),
}
