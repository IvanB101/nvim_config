return {
	"nvim-pack/nvim-spectre",
	config = function()
		local spectre = require("spectre")

		vim.keymap.set("n", "<leader>S", spectre.toggle, { desc = "toggle Spectre" })

		vim.keymap.set("n", "<leader>sp", function()
			spectre.open_visual({ select_word = true })
		end, { desc = "search word under cursor in project" })
		vim.keymap.set("v", "<leader>sp", function()
			vim.cmd("normal y")
			spectre.open({ search_text = vim.fn.getreg('"') })
		end, { desc = "search marked text cursor in project" })

		vim.keymap.set("n", "<leader>sl", function()
			spectre.open_file_search({ select_word = true })
		end, { desc = "search currect word in file" })
		vim.keymap.set("v", "<leader>sl", function()
			vim.cmd("normal y")
			local opts = { search_text = vim.fn.getreg('"') }
			opts.path = vim.fn.fnameescape(vim.fn.expand("%:p:."))

			if vim.loop.os_uname().sysname == "Windows_NT" then
				opts.path = vim.fn.substitute(opts.path, "\\", "/", "g")
			end
			spectre.open(opts)
		end, { desc = "search marked text in cwd" })
	end,
}
