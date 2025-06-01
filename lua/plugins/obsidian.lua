local vault_path = "~/Drive/Obsidian Vault/"

return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	ft = { "markdown" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter",
	},
	opts = {
		workspaces = {
			{
				name = "vault",
				path = vault_path,
			},
		},
		completion = {
			nvim_cmp = true,
		},
		mappings = {
			["<cr>"] = {
				action = "<cmd>ObsidianFollowLink<cr>",
				opts = { noremap = false, buffer = true },
			},
			["<leader>o"] = {
				action = "<cmd>ObsidianOpen<cr>",
				opts = { buffer = true },
			},
		},
		follow_url_func = function(url)
			vim.ui.open(url)
		end,
	},
}
