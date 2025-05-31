local opts = {
	formatters_by_ft = {
		sh = { "beautysh" },
		zsh = { "beautysh" },
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		-- rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
}

return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup(opts)

		local filetypes = {}
		for ft in pairs(opts.formatters_by_ft) do
			filetypes[#filetypes + 1] = ft
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.keymap.set({ "n", "x" }, "<leader>fm", function()
					conform.format({ async = true })
				end, { buffer = true })
			end,
		})
	end,
}
