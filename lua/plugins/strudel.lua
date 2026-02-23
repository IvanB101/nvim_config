vim.env.ELECTRON_FLAGS = "--no-sandbox"

local opts = {
	update_on_save = true,
	-- headless = true,
}

local function hush()
	local col = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(0, 0, col, true)
	while not lines[col]:find("^_?%$") do
		if col == 1 then
			return
		end
		col = col - 1
	end
	local line = lines[col]
	vim.schedule(function()
		vim.api.nvim_buf_set_lines(0, col - 1, col, true, {
			line:match("^_") and line:sub(2) or "_" .. line,
		})
		-- vim.cmd("w")
		-- vim.cmd("StrudelUpdate")
	end)
end

return {
	"gruvw/strudel.nvim",
	config = function()
		local strudel = require("strudel")
		strudel.setup(opts)
		local remap = vim.keymap.set

		remap("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
		remap("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
		remap("n", "<leader>st", strudel.toggle, { desc = "Strudel Toggle Play/Stop" })
		remap("n", "<leader>su", strudel.update, { desc = "Strudel Update" })
		remap("n", "<leader>ss", strudel.stop, { desc = "Strudel Stop Playback" })
		remap("n", "<leader>sb", strudel.set_buffer, { desc = "Strudel set current buffer" })
		remap("n", "<leader>sx", strudel.execute, { desc = "Strudel set current buffer and update" })

		-- local editor = require("utils.editor")
		remap("n", "<leader>h", hush, { desc = "Hush" })
	end,
}
