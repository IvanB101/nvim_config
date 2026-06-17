-- mapped to <leader>fm or on save
-- vim.lsp.buf.code_action({
--   context = { only = { "source.fixAll.eslint" } },
--   apply = true,
-- })
return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			idea_format = {
				format = function(_, ctx, _, _)
					vim.fn.system({"curl", "http://localhost:63342/api/format\\?path=" .. ctx.filename})
                    vim.cmd("edit ".. ctx.filename)
				end,
			},
		},
		formatters_by_ft = {
			java = { "idea_format" },
			json = { "prettier" },
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

