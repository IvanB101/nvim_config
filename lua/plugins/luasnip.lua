local remap = vim.keymap.set
local opts = {
	history = true,
	updateevents = "TextChanged,TextChangedI",
	-- Enable autotriggered snippets
	enable_autosnippets = true,
	-- Use Tab (or some other key if you prefer) to trigger visual selection
	store_selection_keys = "<Tab>",
	-- show insert node changes live
	update_events = "TextChanged,TextChangedI",
}

local ft_extentions = {
	tex = { "mathjax" },
	markdown = { "mathjax" },
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
	end,
}
