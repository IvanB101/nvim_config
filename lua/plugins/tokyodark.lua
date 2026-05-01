local opts = {
	transparent_background = true,
	gamma = 1.00,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		identifiers = { italic = true },
		functions = {},
		variables = {},
	},
	custom_highlights = {
		Type = { fg = "#0d889e" },
		Structure = { fg = "#000000" },
	},
	custom_palette = {
		fg = "#a0a8cd",
		red = "#be00d2",
		orange = "#f6754b",
		yellow = "#d7a65f",
		green = "#75c541",
		blue = "#0d889e",
		cyan = "#38a89d",
		purple = "#1967ea",
		grey = "#5a6067",
		none = "NONE",
	},
	terminal_colors = true,
}

return {
	"tiagovla/tokyodark.nvim",
	config = function()
		require("tokyodark").setup(opts)
	end,
}
