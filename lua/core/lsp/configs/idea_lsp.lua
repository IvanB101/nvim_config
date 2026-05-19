local M = {
  host = "127.0.0.1",
  port = 9999,
  filetypes = { "java" },
  root_markers = { ".git", "pom.xml", "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts", },
  root_dir = nil,
}

local function search_root(bufnr)
	local function is_pom_with_modules(path)
		local f = io.open(path, "r") or error("no such directory " .. path)
		local content = f:read("*all")
		f:close()
		return content:find("<modules>")
	end

	local dir = require("lspconfig.util").root_pattern(M.root_markers)(vim.fn.expand("%:p"))
	local last_dir = ""
	while dir ~= last_dir do
		local pom = dir .. "/pom.xml"
		if vim.fn.filereadable(pom) == 1 and is_pom_with_modules(pom) then
			return dir
		end
		local parent = vim.uv.fs_realpath(dir .. "/..") or error("Project root not found")
		last_dir = dir
		if vim.fn.filereadable(parent .. "/pom.xml") == 1 then
			dir = parent
		end
	end
	return dir
end

local function start(bufnr)
  local root = search_root(bufnr)
  if not root then
    return
  end
  vim.lsp.start({
    name = "idea-lsp",
    cmd = vim.lsp.rpc.connect(M.host, M.port),
    root_dir = root,
  })
end

function M.setup(opts)
  if opts then
    for k, v in pairs(opts) do
      M[k] = v
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("idea-lsp", { clear = true }),
    pattern = M.filetypes,
    callback = function(args)
      start(args.buf)
    end,
  })

  vim.api.nvim_create_user_command("IdeaLspStart", function()
    start(0)
  end, { desc = "Attach idea-lsp to the current buffer" })

  vim.api.nvim_create_user_command("IdeaLspStop", function()
    for _, client in ipairs(vim.lsp.get_clients({ name = "idea-lsp" })) do
      client:stop()
    end
  end, { desc = "Detach all idea-lsp clients" })
end

M.setup()

return M
