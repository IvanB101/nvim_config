return {
	"windwp/nvim-autopairs",
	opts = {
		fast_wrap = {},
		disable_filetype = { "TelescopePrompt", "vim" },
	},
	config = function(opts)
		local npairs = require("nvim-autopairs")
		npairs.setup(opts)
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")

		npairs.add_rule(Rule("$", "$", { "tex", "markdown" }))

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
