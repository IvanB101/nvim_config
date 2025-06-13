local config = function()
	local cmp = require("cmp")

	local options = {
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-c>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
			["<tab>"] = cmp.mapping(function(fallback)
				local luasnip = require("luasnip")

				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<s-tab>"] = cmp.mapping(function(fallback)
				local luasnip = require("luasnip")

				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		sources = {
			{ name = "nvim_lsp" },
			-- { name = "buffer" },
			{ name = "nvim_lua" },
			{ name = "path" },
			{ name = "crates" },
			{ name = "lazydev" },
			{ name = "luasnip", option = { show_autosnippets = true } },
		},
	}

	cmp.setup(options)
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
		"windwp/nvim-autopairs",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	config = config,
}
