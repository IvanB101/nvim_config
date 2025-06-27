local remap = vim.keymap.set
local builtin = require("telescope.builtin")

remap("n", "<leader>ff", builtin.find_files, { desc = "find files" })
remap("n", "<leader>fp", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "project grep" })
remap("n", "<leader>fl", builtin.live_grep, { desc = "project grep" })
remap("n", "<leader>fg", builtin.git_files, { desc = "find git files" })
remap("n", "<leader>fr", builtin.lsp_references, { desc = "find git files" })
remap("n", "<leader>fs", builtin.lsp_workspace_symbols, { desc = "find workspace symbols" })
remap("n", "<leader>fbs", builtin.lsp_document_symbols, { desc = "find document symbols" })
remap("n", "<leader>fd", builtin.diagnostics, { desc = "telescope diagnostics" })
remap("n", "<leader>fbd", function()
	builtin.diagnostics({ bufnr = 0 })
end, { desc = "telescope buffer diagnostics" })
remap("n", "<leader>fk", builtin.keymaps, { desc = "key mappings" })

remap("n", "<leader>th", builtin.colorscheme, { desc = "key mappings" })

return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	cmd = "Telescope",
	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				mappings = {
					n = {
						["o"] = actions.select_tab,
					},
				},
			},
		}
	end,
}
