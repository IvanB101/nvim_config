local base = require("core.lsp.base")
local registry = require("mason-registry")
local mason_map = require("mason-lspconfig.mappings").get_mason_map()

local exclude = {
	"jdtls",
}

for _, package in ipairs(registry.get_installed_packages()) do
	if vim.list_contains(exclude, package.name) then
		goto continue
	end
	local categories = package.spec.categories or {}
	if vim.list_contains(categories, "LSP") then
		local lsp = mason_map.package_to_lspconfig[package.name]
		local config = base

		local ok, custom = pcall(function()
			return require("core.lsp.configs." .. lsp)
		end)
		if ok then
			config = vim.tbl_deep_extend("force", config, custom)
		end

		vim.lsp.config(lsp, config)
		vim.lsp.enable(lsp)
	end
	::continue::
end
