local function search_root()
	local function is_pom_with_modules(path)
		local f = io.open(path, "r")
		if not f then
			return false
		end
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
		local parent_pom = parent .. "/pom.xml"
		last_dir = dir
		if vim.fn.filereadable(parent_pom) == 1 then
			dir = parent
		end
	end
	return dir
end

local lsp_config = require("plugins.lspconfig").export
local jdtls = require("jdtls")

local function directory_exists(path)
	local f = io.popen("cd " .. path)
	return f and not f:read("*all"):find("ItemNotFoundException")
end

local root_dir = search_root()

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
-- vim.list_extend(
-- 	bundles,
-- 	vim.split(
-- 		vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
-- 		"\n"
-- 	)
-- )

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
		"-Xmx4g",
		"-XX:ParallelGCThreads=4",
		"-XX:ConcGCThreads=2",
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
				organizeImports = true,
			},
			completion = {
				maxResults = 20,
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
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
		},
	},
	init_options = {
		bundles = bundles,
	},
	on_attach = function(client, bufnr)
		lsp_config.on_attach(client, bufnr)
		-- local _, _ = pcall(vim.lsp.codelens.refresh)
		-- require("jdtls.dap").setup_dap_main_class_configs()
		-- jdtls.setup_dap({ hotcodereplace = "auto" })
	end,
}

jdtls.start_or_attach(config)
