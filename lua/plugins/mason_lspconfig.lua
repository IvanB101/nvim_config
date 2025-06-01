return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("mason-lspconfig").setup({})
		-- auto_enable = { exclude = {} } not working for some reason
		vim.lsp._enabled_configs.jdtls = nil
	end,
}
