local colors = {
	bg = {
		status = "NONE",
		main = "NONE",
		selection = "#0c0118",
		"#0000ff",
	},
	purple = {
		base = "#be00d2",
	},
	white = {
		dim = "#6f6f6f",
		base = "#dddddd",
	},
	orange = {
		base = "#f6754b",
	},
	yellow = {
		base = "#D7A65F",
	},
	green = {
		base = "#6bce1d",
	},
	blue = {
		bright = "#1978ff",
		base = "#1967ea",
	},
	pink = {
		base = "#ff54b8",
	},
	turquoise = {
		base = "#0d889e",
		dim = "#005688",
	},
}

local specs = {
	all = {
		-- base = colors.base,
		bg0 = colors.bg.selection,
		bg1 = colors.bg.main,
		bg2 = colors.bg.selection,
		bg3 = colors.bg.selection,
		bg4 = colors.bg[1],
		diag = {
			error = "#f0365d",
			hint = "#81b29a",
			info = "#719cd6",
			ok = "#81b29a",
			warn = "#dbc074",
		},
		diag_bg = {
			error = colors.bg.main,
			hint = colors.bg.main,
			info = colors.bg.main,
			ok = colors.bg.main,
			warn = colors.bg.main,
		},
		syntax = {
			-- bracket = "#aeafb0",
			builtin0 = colors.turquoise.base,
			builtin1 = colors.orange.base,
			builtin2 = colors.pink.base,
			builtin3 = colors.blue.bright, -- interfaces
			comment = colors.white.dim,
			conditional = colors.purple.base,
			const = colors.yellow.base,
			dep = "#000000",
			field = colors.orange.base,
			func = colors.green.base,
			ident = colors.white.dim, -- telescope cursor
			keyword = colors.purple.base,
			number = colors.yellow.base,
			operator = colors.purple.base,
			preproc = colors.pink.base,
			regex = "#e0c989",
			statement = "#000000",
			string = colors.yellow.base,
			type = colors.turquoise.base,
			variable = colors.white.base,
		},
		diff = {
			add = "#26343c",
			change = "#243244",
			delete = "#2f2837",
			text = "#253f4a",
		},
		fg0 = "#ff0000",
		fg1 = colors.white.base,
		fg2 = colors.white.base,
		fg3 = colors.white.dim,
		git = {
			add = "#81b29a",
			changed = "#f4a261",
			conflict = "#f4a261",
			ignored = "#738091",
			removed = "#c94f6d",
		},
	},
}

local groups = {
	all = {
		NormalFloat = { bg = "NONE" },
		FloatBorder = { bg = "NONE" },
		FloatTitle = { bg = "NONE" },
		TelescopeBorder = { bg = "NONE", fg = colors.white.dim },
		TelescopePromptCounter = { bg = "NONE", fg = colors.white.dim },
		Tabline = { bg = "NONE" },
		TablineSel = { bg = "NONE" },
		TablineFill = { bg = "NONE" },
		StatusLine = { bg = "NONE" },
		Pmenu = { bg = "NONE" },
		PmenuSel = { link = "Visual" },
		-- PmenuSbar = { bg = colors.bg.selection },
		-- PmenuThumb = { bg = colors.bg.selection },
		FugitiveStagedModifier = { fg = colors.purple.base },
		FugitiveUnstagedModifier = { fg = colors.turquoise.base },
		FugitiveStagedSection = { fg = colors.white.base },
		FugitiveUnstagedSection = { fg = colors.white.base },
		FugitiveHash = { fg = colors.orange.base },
		FugitiveRef = { fg = colors.white.base },
		["@keyword.operator"] = { link = "keyword" },
		["@variable.kulala_http"] = { link = "variable" },
		yamlBlockMappingKey = { fg = colors.orange.base },
        cucumberScenario = { link = "type" },
        cucumberTags = { link = "preproc" },
	},
}

local opts = {
	options = {
		transparent = true,
	},
	specs = specs,
	groups = groups,
}

return {
	"EdenEast/nightfox.nvim",
	config = function()
		require("nightfox").setup(opts)
		vim.cmd("colorscheme nightfox")
	end,
}
