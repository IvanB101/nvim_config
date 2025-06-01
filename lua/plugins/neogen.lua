return {
	"danymat/neogen",
	config = function(opts)
		local neogen = require("neogen")
		local remap = vim.keymap.set

		remap("n", "do", neogen.generate, { noremap = true, silent = true })
		neogen.setup(opts)
	end,
}
