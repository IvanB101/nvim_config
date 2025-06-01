local bind = function(lhs, rhs)
	vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
end

bind("dd", '_yw<C-l>:tab Gvdiffsplit <C-r>"<cr>')
