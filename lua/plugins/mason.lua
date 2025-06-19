local opts = {
	ensure_installed = {
		"beautysh",
		"black",
		"bash-language-server",
		"clangd",
		"codelldb",
		"glsl_analyzer",
		"html-lsp",
		"java-debug-adapter",
		"java-test",
		"jdtls",
		"lemminx",
		"lua-language-server",
		"ltex-ls",
		"mypy",
		"pyright",
		"stylua",
		"texlab",
		"zls",
	},
}

return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		config = function()
			require("mason").setup(opts)

			vim.api.nvim_create_user_command("MasonInstallAll", function()
				if opts.ensure_installed and #opts.ensure_installed > 0 then
					vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
				end
			end, {})
			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = { automatic_enable = false },
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		config = true,
	},
}
