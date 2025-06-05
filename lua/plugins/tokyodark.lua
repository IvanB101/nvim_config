local opts = {
	transparent_background = true,
	gamma = 1.00,
	styles = {
		comments = { italic = true }, -- style for comments
		keywords = { italic = true }, -- style for keywords
		identifiers = { italic = true }, -- style for identifiers
		functions = {}, -- style for functions
		variables = {}, -- style for variables
	},
	custom_highlights = {
		-- Type = { fg = "#A0A8CD" },
		-- Structure = { fg = "#A0A8CD" },
	},
	custom_palette = {
		fg = "#A0A8CD",
		red = "#FF3D75",
		orange = "#F6754B",
		yellow = "#D7A65F",
		green = "#75C541",
		blue = "#2e6fd0",
		cyan = "#38A89D",
		purple = "#A445DD",
		grey = "#5A6067",
		none = "NONE",
	},
	terminal_colors = true, -- enable terminal colors
}

return {
	"tiagovla/tokyodark.nvim",
	config = function()
		require("tokyodark").setup(opts) -- calling setup is optional
		vim.cmd([[colorscheme tokyodark]])
	end,
}
