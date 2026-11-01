return {
	init_options = {
		collections = {
			{ name = "structures", path = "~/Repos/odin-data-structures/" },
			{ name = "physics", path = "~/Repos/odin-physics-lib/" },
		},

		checker_args = "-strict-style",
		-- enable_checker_workspace_diagnostics = true,
		checker_path = { "src" },
	},
}
