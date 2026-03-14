local remap = vim.keymap.set
local utils = require("utils")

remap("n", "<leader>e", vim.cmd.Ex, { desc = "open netrw" })

remap({ "n", "v", "o" }, "L", "$", { desc = "go to line end", remap = true })
remap({ "n", "v", "o" }, "H", "^", { desc = "go to line start", remap = true })

remap("n", "D", vim.diagnostic.open_float, { desc = "open float diagnostic" })

remap("v", "J", ":m '>+1<CR>gv=gv", { desc = "move marked text down" })
remap("v", "K", ":m '<-2<CR>gv=gv", { desc = "move marked text up" })
remap("n", "J", "mzJ`z", { desc = "J maintains cursor position" })
remap("n", "<C-d>", "<C-d>zz", { desc = "centeres <C-d>" })
remap("n", "<C-u>", "<C-u>zz", { desc = "centeres <C-u>" })
remap("n", "n", "nzzzv", { desc = "Centered cursor n" })
remap("n", "N", "Nzzzv", { desc = "Centered cursor N" })

remap({ "n", "v" }, "<leader>y", '"+y', { desc = "yank to clipboard" })
remap({ "n", "v" }, "<leader>p", '"+p', { desc = "paste from system clipboard" })
remap({ "n", "v" }, "<leader>P", '"+P', { desc = "paste from system clipboard before cursor" })

remap("v", "c", '"_dP', { desc = "replace marked with clipboard" })
remap("v", "<leader>c", '"_d"+P', { desc = "replace marked with system clipboard" })

remap("v", "r", 'y:s/<C-r>"/<C-r>"/g<Left><Left>', { desc = "replace ocurrencies of marked text in line" })
remap("v", "R", 'y:%s/<C-r>"/<C-r>"/g<Left><Left>', { desc = "replace ocurrencies of marked text in line" })

remap("n", "U", "<C-r>", { desc = "redo" })
remap("n", "<C-z>", "<nop>", { desc = "nothing" })

remap("n", "<leader>sw", "y/<C-r><C-w><cr>", {
	desc = "search ocurrencies of word under cursor",
})
remap("v", "<Enter>", 'y/<C-r>"<cr>', {
	desc = "search ocurrencies of marked text ",
})

remap("n", "<leader>q", function()
	utils.quickfix.toggle()
end, { desc = "toggle quickfix list" })
remap("n", "]q", "<cmd>cnext<cr>", { desc = "go to next entry in quickfix list" })
remap("n", "[q", "<cmd>cprev<cr>", { desc = "go to previous entry in quickfix list" })

remap("n", "<leader>vs", "<cmd>vsplit<cr>", { desc = "split window (vertical)" })
remap("n", "<leader>hs", "<cmd>split<cr>", { desc = "split window (horizontal)" })

remap("n", "<C-n>", "gt", { desc = "go to next tab" })
remap("n", "<C-p>", "gT", { desc = "go to previos tab" })

remap("n", "Q", "<cmd>tabclose<cr>", { desc = "close tab" })
remap("n", "<leader>n", "<cmd>tab split<cr>", { desc = "new tab" })
remap("n", "<leader>T", "<C-w>T", { desc = "open current split window in new tab" })

remap("n", "<leader>tc", function()
	utils.editor.replace_word_under_cursor(utils.string.toggle_case)
end, { desc = "toggle case of word under cursor" })

remap("c", "<C-h>", "<s-left>", { desc = "go left one word" })
remap("c", "<C-l>", "<s-right>", { desc = "go right one word" })

remap("c", "<C-g>", "\\(\\)<left><left>", { desc = "open capture group" })
