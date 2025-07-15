vim.g.vimtex_quickfix_open_on_warning = 0

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "okular"

vim.keymap.set("n", "<leader>lv", vim.cmd.VimtexView, { desc = "vimtex view" })
vim.keymap.set("n", "<leader>lc", vim.cmd.VimtexCompile, { desc = "vimtex compile" })

vim.g.vimtex_compiler_engine = "xelatex"

vim.g.vimtex_compiler_latexmk = {
	options = {
		"-shell-escape",
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
	},
}

return { "lervag/vimtex" }
