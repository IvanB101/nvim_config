return {
	"saghen/blink.cmp",
	version = "1.8.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
			["<s-tab>"] = { "select_prev", "fallback" },
			["<tab>"] = { "select_next", "fallback" },
		},
		signature = { enabled = true },
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
}
