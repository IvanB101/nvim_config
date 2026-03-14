vim.keymap.set({ "n", "v" }, "<leader>R", function()
	require("kulala").run()
end, { desc = "Send request" })

return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
}
