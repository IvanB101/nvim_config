local remap = vim.keymap.set

remap("n", "<leader>R", function()
	vim.cmd("1TermExec cmd='odin run .'")
	vim.cmd("ToggleTerm")
end, { desc = "run current project root" })
