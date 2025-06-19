local remap = vim.keymap.set
local function loadSnippets()
	require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/luasnip/" } })
end

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

return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")
		ls.setup(opts)
		loadSnippets()
		remap("n", "<leader>L", loadSnippets, { desc = "reload snippets" })
	end,
}
