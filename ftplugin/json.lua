local remap = vim.keymap.set
local format = require("conform").format

remap({ "n", "x" }, "<leader>fm", format, { buffer = false })
