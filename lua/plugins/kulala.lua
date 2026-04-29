return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		kulala_keymaps = {
            ["Show headers"] = false,
            ["Show body"] = false,
            ["Show verbose"] = { "<leader>v", function() require("kulala.ui").show_verbose() end, },
            ["Show report"] = { "<leader>r", function() require("kulala.ui").show_report() end, },
            ["Show headers and body"] = { "<leader>a", function() require("kulala.ui").show_headers_body() end, },
            ["Show script output"] = { "<leader>o", function() require("kulala.ui").show_script_output() end, },
        },
		global_keymaps_prefix = "<leader>r",
		kulala_keymaps_prefix = "",
		lsp = {
			filetypes = { "http", "rest", "json", "yaml", "bruno", "javascript" },
		},
	},
}
