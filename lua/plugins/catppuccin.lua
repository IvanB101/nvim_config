local opts = {
    flavour = "auto",
    background = {
        dark = "mocha"
    }
}

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = false,
	config = function()
		require("catppuccin").setup(opts)
		vim.cmd([[colorscheme catppuccin]])
	end,
}
