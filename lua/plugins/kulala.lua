local str = require("utils.string")

return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		global_keymaps = {
			["Send request"] = {
				"<C-cr>",
				function()
					require("kulala").run()
				end,
			},
			["OB-trace"] = {
				"<leader>tr",
				function()
					local responses = require("kulala.db").global_update().responses
					if #responses == 0 then
						return
					end
					local last = responses[#responses]
					for line in str.lines(last.headers) do
						local _, e = line:find("Ob%-Audit%-Trace%-Id: ")
						if e ~= nil then
							vim.fn.setreg("+", line:sub(e + 1))
							return
						end
					end
					vim.notify("OB-trace not found", vim.log.levels.INFO)
				end,
			},
		},
		kulala_keymaps = {
			["Show headers"] = false,
			["Show body"] = false,
			["Show verbose"] = {
				"<leader>v",
				function()
					require("kulala.ui").show_verbose()
				end,
			},
			["Show report"] = {
				"<leader>r",
				function()
					require("kulala.ui").show_report()
				end,
			},
			["Show headers and body"] = {
				"<leader>a",
				function()
					require("kulala.ui").show_headers_body()
				end,
			},
			["Show script output"] = {
				"<leader>o",
				function()
					require("kulala.ui").show_script_output()
				end,
			},
		},
		global_keymaps_prefix = "<leader>r",
		kulala_keymaps_prefix = "",
		lsp = {
			filetypes = { "http", "rest", "json", "yaml", "bruno", "javascript" },
		},
	},
}
