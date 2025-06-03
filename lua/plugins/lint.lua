local linters_by_ft = {
	-- typescript = { "eslint_d" },
}

return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = linters_by_ft

		vim.api.nvim_create_autocmd("BufReadPost", {
			callback = function(args)
				local filetype = vim.bo.filetype
				if linters_by_ft[filetype] then
					vim.api.nvim_create_autocmd("BufWritePost", {
						buffer = args.buf,
						callback = function()
							lint.try_lint()
						end,
					})
				end
			end,
		})
	end,
}
