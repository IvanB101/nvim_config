local bridge_settings = {
	obsidian_server_address = "https://127.0.0.1:27124",
	cert_path = "~/.ssl/obsidian-local-rest-api.crt",
	scroll_sync = true,
	warnings = true,
	picker = "telescope",
}

return {
	"oflisback/obsidian-bridge.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("obsidian-bridge").setup(bridge_settings)
		vim.keymap.set("n", "<leader>O", "<cmd>ObsidianBridgeToggle<cr>")
	end,
	opts = bridge_settings,
	event = {
		"BufReadPre *.md",
		"BufNewFile *.md",
	},
}
