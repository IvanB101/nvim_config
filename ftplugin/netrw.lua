local bind = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true, desc = desc })
end

bind("s", "<nop>")

bind("O", "t", "open in file new tab")

bind("h", "-", "go to parent directory")
bind("l", "<cr>", "go to directory or open file")

bind("r", "R", "rename")

bind("f", "mf", "mark file")
bind("u", "mf", "unmark all files")
bind("b", "mb", "bookmark directory")

bind("c", "<cmd>cd %<cr>mc<cmd>cd -<cr>", "copy marked files to target directory")
bind("x", "<cmd>cd %<cr>mm<cmd>cd -<cr>", "move marked files to target directory")
