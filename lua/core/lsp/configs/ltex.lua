local lspconfig = require("core.lsp.base")

return {
	filetypes = {
		"bib",
		"gitcommit",
		-- "markdown",
		"org",
		"plaintex",
		"rst",
		"rnoweb",
		"tex",
		"pandoc",
		"quarto",
		"rmd",
		"context",
		-- "html",
		-- "xhtml",
		-- "mail",
		-- "text",
	},
	settings = {
		ltex = {
			language = "es",
			additionalRules = {
				languageModel = "~/.models/ngrams/",
				-- enablePickyRules = true,
			},
			disabledRules = {
				["es"] = {
					"MORFOLOGIK_RULE_ES",
					"\\\\\\\\cite{.*}",
					"\\\\\\\\acr\\\\w*{.*}",
				},
				["en"] = { "MORFOLOGIK_RULE_EN" },
			},
		},
	},
	on_attach = function(client, bufnr)
		lspconfig.on_attach(client, bufnr)
		require("ltex_extra").setup({
			path = "./.ltex/",
		})
	end,
}
