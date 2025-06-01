local user_cmd = vim.api.nvim_create_user_command

user_cmd("CleanSwap", function()
	vim.cmd("silent !rm ~/.local/state/nvim/swap/*")
end, { desc = "clean swap" })

user_cmd("MarkSelectedFiles", function()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	for lnum = start_line, end_line do
		vim.fn.cursor(lnum, 1)
		vim.cmd("normal mf")
	end
end, { range = true })

local core = {}

local patterns = {
	python = "*.py",
	lua = "*.lua",
	javascript = "*.js",
	typescript = "*.ts",
	typescriptreact = "*.tsx",
	javascriptreact = "*.jsx",
	go = "*.go",
	rust = "*.rs",
	c = "*.c",
	cpp = "*.cpp",
	csharp = "*.cs",
	java = "*.java",
	ruby = "*.rb",
	php = "*.php",
	sh = "*.sh",
	zsh = "*.zsh",
	bash = "*.bash",
	perl = "*.pl",
	r = "*.R",
	swift = "*.swift",
	kotlin = "*.kt",
	scala = "*.scala",
	dart = "*.dart",

	html = "*.html",
	css = "*.css",
	scss = "*.scss",
	sass = "*.sass",
	less = "*.less",
	json = "*.json",
	yaml = "*.yml,*.yaml",
	toml = "*.toml",
	xml = "*.xml",
	markdown = "*.md",
	tex = "*.tex",

	vim = "*.vim",
	vimrc = "*.vimrc",
	lua_config = "*.lua",
	gitconfig = "*.gitconfig",
	dockerfile = "Dockerfile",
	makefile = "Makefile",
	zshrc = "*.zshrc",
	bashrc = "*.bashrc",

	csv = "*.csv",
	tsv = "*.tsv",
	ini = "*.ini",
	env = "*.env",
}

---@param filetype string
---@return string - corresponding pattern to given filetype
core.get_pattern = function(filetype)
	return patterns[filetype]
end

return core
