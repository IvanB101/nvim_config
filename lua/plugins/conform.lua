return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			idea_format = {
				format = function(self, ctx, lines, callback)
					vim.fn.system({"curl", "http://localhost:63342/api/format\\?path=" .. ctx.filename})
                    vim.cmd("edit ".. ctx.filename)
				end,
			},
		},
		formatters_by_ft = {
			java = { "idea_format" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			html = { "prettierd" },
			lua = { "stylua" },
			python = { "black" },
			sh = { "beautysh" },
			zsh = { "beautysh" },
		},
		-- format_on_save = {
		-- 	-- These options will be passed to conform.format()
		-- 	timeout_ms = 500,
		-- 	lsp_format = "fallback",
		-- },
	},
}
