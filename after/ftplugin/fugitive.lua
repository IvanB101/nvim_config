local remap = vim.keymap.set
local bind = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true, desc = desc })
end

local function open_file()
    local ft, file = vim.api.nvim_get_current_line():match("([^ ]*) ([^ ]*)")
    if ft == "U" then
        vim.cmd("tab edit " .. file)
        vim.cmd("Gdiffsplit!")
    else
        vim.cmd("tab edit " .. file)
    end
end


bind("dd", "O<cmd>Gdiffsplit<cr>", "diffsplit in new tab")
bind("g?", "<cmd>tab help fugitive<cr>")

remap({ "n", "v" }, "s", "-", { remap = true, buffer = true })

bind("O", open_file)
