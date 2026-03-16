local remap = vim.keymap.set
local opts = {
	history = true,
	region_check_events = { "CursorMoved" },
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
	update_events = "TextChanged,TextChangedI",
}

local ft_extentions = {
	tex = { "mathjax" },
	markdown = { "mathjax", "html" },
	typescript = { "javascript" },
	typescriptreact = { "html", "typescript", "javascriptreact" },
}

return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")
		local load = require("luasnip.loaders.from_lua").load
		local paths = { "~/.config/nvim/luasnip/" }

		ls.setup(opts)
		for ft, extentions in pairs(ft_extentions) do
			ls.filetype_extend(ft, extentions)
		end
		load({ paths = paths })
		remap("n", "<leader>L", function()
			load({ paths = paths })
		end, { desc = "reload snippets" })

		remap({ "i", "s" }, "<C-e>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })
	end,
}
