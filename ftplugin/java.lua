local function search_root()
	local function is_pom_with_modules(path)
		local f = io.open(path, "r") or error("no such directory " .. path)
		local content = f:read("*all")
		f:close()
		return content:find("<modules>")
	end

	local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
	local dir = require("lspconfig.util").root_pattern(root_markers)(vim.fn.expand("%:p"))
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

local function get_test_method_name()
	local parser = vim.treesitter.get_parser(0)
	if not parser then
		vim.notify("No treesitter parser found for java", vim.log.levels.ERROR)
		return nil
	end
	local tree = parser:parse()[1]
	local root = tree:root()
	local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
	local node = root:named_descendant_for_range(cursor_row - 1, cursor_col, cursor_row - 1, cursor_col)
	if not node then
		vim.notify("Cursor is not in a valid position", vim.log.levels.ERROR)
		return nil
	end

	---@type TSNode?
	local current = node
	while current do
		if current:type() == "method_declaration" then
			local annotation_text = vim.treesitter.get_node_text(current, 0)
			if annotation_text:find("@Test") then
				for child in current:iter_children() do
					if child:type() == "identifier" then
						return vim.treesitter.get_node_text(child, 0)
					end
				end
			end
			break
		end
		current = current:parent()
	end
	return nil
end

local function load_mappings(opts)
	local fs = require("utils.fs")
	local remap = vim.keymap.set

	remap("n", "<leader>tf", function()
		local arg = ' -Dtest="' .. fs.cwf():gsub("^.*/java/", ""):gsub(".java.*$", ""):gsub("/", ".") .. '"'
		vim.cmd("1TermExec cmd='mvn test" .. arg .. "'")
	end, vim.tbl_extend("force", opts, { desc = "test current file" }))
	remap("n", "<leader>T", function()
		local method = get_test_method_name()
		if method == nil then
			return
		end
		local arg = ' -Dtest=\\"'
			.. fs.cwf():gsub("^.*/java/", ""):gsub(".java.*$", ""):gsub("/", ".")
			.. "\\#"
			.. method
			.. '\\"'
		vim.cmd("1TermExec cmd='mvn test" .. arg .. "'")
	end, vim.tbl_extend("force", opts, { desc = "test current method" }))
end

local lsp_config = require("core.lsp.base")
local jdtls = require("jdtls")

local function directory_exists(path)
	local f = io.popen("cd " .. path)
	return f and not f:read("*all"):find("ItemNotFoundException")
end

local root_dir = search_root()
require("core.state").update({ root_dir = root_dir })

-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace/" .. project_name
if not directory_exists(workspace_dir) then
	os.execute("mkdir " .. workspace_dir)
end
-- get the current OS
local os_name = vim.loop.os_uname().sysname:lower()

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
local install_path = mason_path .. "packages/jdtls/"
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
		"\n"
	)
)

local config = {
	cmd = {
		"java", -- must be version 21 or higher
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. install_path .. "lombok.jar",
		"-Xms2g",
		-- "-Xmx4g",
		"-XX:ParallelGCThreads=6",
		"-XX:ConcGCThreads=3",
		"--module-path",
		root_dir,
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(install_path .. "plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		install_path .. "config_" .. os_name,
		"-Dosgi.sharedConfiguration.area.readOnly=true",
		"-data",
		workspace_dir,
	},
	capabilities = lsp_config.capabilities,
	root_dir = root_dir,
	settings = {
		java = {
			signatureHelp = {
				enabled = true,
			},
			saveActions = {
				organizeImports = false,
			},
			completion = {
				maxResults = 20,
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			references = {
				includeDecompiledSources = true,
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
			},
			referencesCodeLens = { enabled = false },
			implementationsCodeLens = { enabled = false },
			inlayHints = { parameterNames = { enabled = "none" } },
			format = {
				settings = {
					url = vim.fn.glob("~/.config/nvim/lua/core/formatters/configs/jdtls.xml"),
					profile = "CustomJavaFormat", -- The profile name in the XML
				},
			},
		},
	},
	init_options = {
		bundles = bundles,
	},
	on_attach = function(client, bufnr)
		lsp_config.on_attach(client, bufnr)
		load_mappings({ buffer = bufnr })
		require("jdtls.dap").setup_dap_main_class_configs()
		jdtls.setup_dap({ hotcodereplace = "auto" })
	end,
}

jdtls.start_or_attach(config)
