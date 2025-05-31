local remap = vim.keymap.set

local opts = { silent = true, buffer = true }

remap("n", "gd", vim.lsp.buf.definition, opts)
remap("n", "gD", vim.lsp.buf.declaration, opts)
remap("n", "gi", vim.lsp.buf.implementation, opts)
remap("n", "go", vim.lsp.buf.type_definition, opts)
remap("n", "gr", vim.lsp.buf.references, opts)
remap("n", "gs", vim.lsp.buf.signature_help, opts)
remap("n", "<leader>ra", vim.lsp.buf.rename, opts)
remap({ "n", "x" }, "<leader>fm", function()
	vim.lsp.buf.format({ async = true })
end, opts)

remap("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction")
end, opts)
remap("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, opts)

remap("n", "<leader>E", function()
	vim.cmd.RustLsp("explainError")
end, opts)

remap("n", "<C-e>", "<cmd>RustLsp expandMacro<cr>", { desc = "expand macro" })

vim.api.nvim_create_user_command("Dbg", function()
	vim.cmd.RustLsp("debug")
end, { desc = "debug (search target from cursor)" })
vim.api.nvim_create_user_command("Dbgs", function()
	vim.cmd.RustLsp("debuggables")
end, { desc = "show debuggables" })
vim.api.nvim_create_user_command("Run", function()
	vim.cmd.RustLsp("run")
end, { desc = "run (search target from cursor)" })
vim.api.nvim_create_user_command("Runs", function()
	vim.cmd.RustLsp("runnables")
end, { desc = "show runnables" })
