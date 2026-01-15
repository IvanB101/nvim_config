return {
	"saghen/blink.pairs",
	version = "*",
	-- download prebuilt binaries from github releases
	dependencies = "saghen/blink.download",
	--- @module 'blink.pairs'
	--- @type blink.pairs.Config
	opts = {
		mappings = {
			cmdline = false,
			pairs = {
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
			},
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
			},
		},
	},
}
