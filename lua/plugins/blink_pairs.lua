local function not_autosnippet(ctx)
	return ctx:text_before_cursor(1) ~= ";"
end

local custom_pairs = {
	["$"] = {
		{
			"$$",
			"$$",
			when = function(ctx)
				return ctx:text_before_cursor(1) == "$"
			end,
			languages = { "markdown", "markdown_inline" },
		},
		{
			"$",
			languages = { "markdown", "markdown_inline", "typst", "latex", "plaintex" },
		},
	},
}

local languages = { "markdown", "markdown_inline", "typst", "latex", "plaintex" }
local used_in_snippets = { ["("] = ")", ["["] = "]", ["{"] = "}" }
for open, close in pairs(used_in_snippets) do
	custom_pairs[open] = {
		{
			close,
			when = not_autosnippet,
			languages = languages,
		},
		{ close },
	}
end

return {
	"saghen/blink.pairs",
    version = "v0.5",
	-- download prebuilt binaries from github releases
	dependencies = "saghen/blink.download",
	--- @module 'blink.pairs'
	--- @type blink.pairs.Config
	opts = {
		mappings = {
			cmdline = false,
			pairs = custom_pairs,
		},
		highlights = {
			enabled = true,
			groups = {
				"BlinkPairsWhite",
				"BlinkPairsOrange",
				"BlinkPairsPurple",
				"BlinkPairsBlue",
			},
			matchparen = {
				enabled = true,
				cmdline = false,
				include_surrounding = false,
				group = "BlinkPairsMatchParen",
				priority = 250,
			},
		},
	},
}
