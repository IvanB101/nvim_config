vim.keymap.set("n", "<C-h>", vim.cmd.TmuxNavigateLeft, { desc = "window left" })
vim.keymap.set("n", "<C-l>", vim.cmd.TmuxNavigateRight, { desc = "window right" })
vim.keymap.set("n", "<C-j>", vim.cmd.TmuxNavigateDown, { desc = "window down" })
vim.keymap.set("n", "<C-k>", vim.cmd.TmuxNavigateUp, { desc = "window up" })

return { "christoomey/vim-tmux-navigator" }
