vim.opt.wrap = true
vim.opt.linebreak = true

local remap = vim.keymap.set

remap({ "n", "v" }, "j", "gj", { desc = "navigate down in visual lines", remap = true, buffer = true })
remap({ "n", "v" }, "k", "gk", { desc = "navigate up in visual lines", remap = true, buffer = true })
remap({ "n", "v" }, "$", "g$", { desc = "navigate to end of visual line", remap = true, buffer = true })
remap({ "n", "v" }, "^", "g^", { desc = "navigate to start of visual line", remap = true, buffer = true })

remap("n", "dd", "0dgj", { desc = "delete visual line", remap = true, buffer = true })
