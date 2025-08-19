local remap = vim.keymap.set

local opts = { silent = true, buffer = true }
local function on_attach()
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

	remap("n", "<leader>R", function()
		vim.cmd.RustLsp("run")
	end, opts)
end

local function config()
	require("rustaceanvim")
	local executors = require("rustaceanvim.executors")

	vim.g.rustaceanvim = {
		---@type rustaceanvim.Opts
		tools = {
			executor = executors.toggleterm,
			test_executor = executors.background,
		},
		server = {
			on_attach = on_attach,
			procMacro = {
				ignored = {
					leptos_macro = {
						"server",
					},
				},
			},
		},
	}

	vim.api.nvim_create_user_command("Debug", function()
		vim.cmd.RustLsp("debug")
	end, { desc = "debug (search target from cursor)" })
	vim.api.nvim_create_user_command("Debuggables", function()
		vim.cmd.RustLsp("debuggables")
	end, { desc = "show debuggables" })
	vim.api.nvim_create_user_command("Runnables", function()
		vim.cmd.RustLsp("runnables")
	end, { desc = "show runnables" })
	vim.api.nvim_create_user_command("Testables", function()
		vim.cmd.RustLsp("testables")
	end, { desc = "show testables" })
end

return {
	"mrcjkb/rustaceanvim",
	lazy = false,
	config = config,
}
