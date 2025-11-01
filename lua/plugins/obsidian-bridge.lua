local opts = {
	obsidian_server_address = "https://127.0.0.1:27124",
	cert_path = "~/.ssl/obsidian-local-rest-api.crt",
	scroll_sync = true,
	warnings = true,
	picker = "telescope",
}

return {
	"oflisback/obsidian-bridge.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{ "<leader>O", "<cmd>ObsidianBridgeToggle<cr>" },
	},
	opts = opts,
	event = {
		"BufReadPre *.md",
		"BufNewFile *.md",
	},
}
