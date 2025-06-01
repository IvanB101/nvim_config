vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.lua_snippets_path = "~/.config/nvim/lua/snippets/"
vim.g.markdown_fenced_languages = { "cpp" }

vim.opt.backup = false
vim.opt.writebackup = false

vim.g.netrw_list_hide = "^\\./$,^\\.\\./$"

vim.opt.ignorecase = true
-- for working with latex
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "okular"
