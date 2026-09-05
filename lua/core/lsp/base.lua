-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"
vim.diagnostic.config({ virtual_text = true })
local remap = vim.keymap.set
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

local angular_filter = function(c)
    -- INFO: current version does not support formatting
	-- local ft = vim.bo.filetype
	-- if ft == "htmlangular" or ft == "html" then
	-- 	return c.name == "angularls"
	-- end
	return c.name == "vtsls" or c.name == "ts_ls"
end

local function angular_eslint_formatter(_)
	pcall(vim.lsp.buf.code_action, {
		context = { only = { "source.fixAll.eslint" } },
		apply = true,
	})

	vim.defer_fn(function()
		vim.lsp.buf.format({ async = false, filter = angular_filter })
	end, 200)
end

local formatters = require("plugins.conform").opts.formatters_by_ft
local function load_mappings(opts)
	local ft = vim.bo[opts.buffer].filetype
	local lsp_fts = {
		typescript = true,
		typescriptreact = true,
		javascript = true,
		html = true,
		htmlangular = true,
		scss = true,
		css = true,
	}
	local format
	if lsp_fts[ft] then
		format = function()
			angular_eslint_formatter(opts.buffer)
		end
	elseif formatters[ft] then
		format = function()
			require("conform").format({ async = true })
		end
	else
		format = function()
			vim.lsp.buf.format({ async = true })
		end
	end
	remap({ "n", "x" }, "<leader>fm", format, opts)

	remap("n", "K", vim.lsp.buf.hover, opts)
	remap("n", "gd", vim.lsp.buf.definition, opts)
	remap("n", "gD", vim.lsp.buf.declaration, opts)
	remap("n", "gi", vim.lsp.buf.implementation, opts)
	remap("n", "go", vim.lsp.buf.type_definition, opts)
	remap("n", "gr", vim.lsp.buf.references, opts)
	remap("n", "gs", vim.lsp.buf.signature_help, opts)
	remap("n", "R", vim.lsp.buf.rename, opts)
	remap("n", "<leader>a", vim.lsp.buf.code_action, opts)
end

local function on_attach(_, bufnr)
	load_mappings({ buffer = bufnr })
end

return {
	root_markers = { ".git" },
	on_attach = on_attach,
	capabilities = capabilities,
}
