local remap = vim.keymap.set
local fs = require("utils.fs")

remap("n", "<leader>tf", function()
	local arg = '-Dcucumber.features="' .. "src/" .. fs.cwf():gsub("^.*/src/", "") .. '"'
	vim.cmd("1TermExec cmd='mvn verify -Dit.test=RunCucumberIT " .. arg .. "'")
end, { desc = "test current feature", buffer = true })
