local remap = vim.keymap.set
local bind = function(lhs, rhs)
	vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
end

bind("dd", "O<cmd>Gdiffsplit<cr>")
bind("g?", "<cmd>tab help fugitive<cr>")

remap({ "n", "v" }, "s", "-", { remap = true, buffer = true })
