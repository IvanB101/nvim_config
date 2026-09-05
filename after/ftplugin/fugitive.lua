local remap = vim.keymap.set
local bind = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true, desc = desc })
end

bind("dd", "O<cmd>Gdiffsplit<cr>", "diffsplit in new tab")
bind("g?", "<cmd>tab help fugitive<cr>")

remap({ "n", "v" }, "s", "-", { remap = true, buffer = true })

bind("<leader>o", function()
	vim.cmd("normal O")
    vim.cmd("Gdiffsplit!")
end)
