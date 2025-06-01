local linters_by_ft = {
	-- markdown = { "vale" },
}
local pattern = {}
local core = require("core")
for ft in pairs(linters_by_ft) do
	pattern[#pattern + 1] = core.get_pattern(ft)
end

return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = linters_by_ft

		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = pattern,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
