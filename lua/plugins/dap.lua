local config = function()
	local dap, dapui = require("dap"), require("dapui")
	local remap = vim.keymap.set

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	local last_run = nil
	dap.listeners.after.event_initialized["store_config"] = function(session)
		if session.config then
			last_run = {
				config = session.config,
			}
		end
	end
	local function dap_run_last()
		if last_run and last_run.config then
			dap.run(last_run.config)
		else
			dap.continue()
		end
	end
	remap({ "n", "v" }, "<F3>", dapui.toggle, { silent = true, desc = "DAP toggle UI" })
	remap({ "n", "v" }, "<F4>", dap.pause, { silent = true, desc = "DAP pause (thread)" })
	remap({ "n", "v" }, "<F5>", dap.continue, { silent = true, desc = "DAP launch or continue" })
	remap({ "n", "v" }, "<F6>", dap.step_into, { silent = true, desc = "DAP step into" })
	remap({ "n", "v" }, "<F7>", dap.step_over, { silent = true, desc = "DAP step over" })
	remap({ "n", "v" }, "<F8>", dap.step_out, { silent = true, desc = "DAP step out" })
	remap({ "n", "v" }, "<F9>", dap.step_back, { silent = true, desc = "DAP step back" })
	remap({ "n", "v" }, "<F10>", dap_run_last, { silent = true, desc = "DAP run last" })
	-- F11 is used by KDE for fullscreen
	remap({ "n", "v" }, "<F12>", dap.terminate, { silent = true, desc = "DAP terminate" })

	remap("n", "<leader>b", vim.cmd.DapToggleBreakpoint, { desc = "toggle break point" })

	dap.configurations.java = {
		{
			type = "java",
			request = "attach",
			name = "Debug (Attach) - Remote",
			hostName = "127.0.0.1",
			port = 5005,
		},
	}

	local opts = {
		controls = {
			icons = {
				pause = " (F4)",
				play = " (F5)",
				step_into = " (F6)",
				step_over = " (F7)",
				step_out = " (F8)",
				step_back = " (F9)",
				run_last = " (F10)",
				terminate = " (F12)",
				disconnect = "",
			},
		},
		layouts = {
			{
				elements = {
					{
						id = "scopes",
						size = 0.40,
					},
					{
						id = "stacks",
						size = 0.35,
					},
					{
						id = "watches",
						size = 0.25,
					},
				},
				position = "right",
				size = 50,
			},
			{
				elements = {
					{
						id = "repl",
						size = 0.65,
					},
					{
						id = "console",
						size = 0.35,
					},
				},
				position = "bottom",
				size = 10,
			},
		},
		mappings = {
			edit = "e",
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			repl = "r",
			toggle = "t",
		},
	}

	dapui.setup(opts)

	-- local telescope_dap = require('telescope').extensions.dap
	--
	-- keymap({ 'n', 'v' }, '<leader>d?', function()
	--     telescope_dap.commands({})
	-- end, { silent = true, desc = 'DAP builtin commands' })
	-- keymap({ 'n', 'v' }, '<leader>dl', function()
	--     telescope_dap.list_breakpoints({})
	-- end, { silent = true, desc = 'DAP breakpoint list' })
	-- keymap({ 'n', 'v' }, '<leader>df', function()
	--     telescope_dap.frames()
	-- end, { silent = true, desc = 'DAP frames' })
	-- keymap({ 'n', 'v' }, '<leader>dv', function()
	--     telescope_dap.variables()
	-- end, { silent = true, desc = 'DAP variables' })
	-- keymap({ 'n', 'v' }, '<leader>dc', function()
	--     telescope_dap.configurations()
	-- end, { silent = true, desc = 'DAP debugger configurations' })
	--
	-- require('telescope').load_extension('dap')
	--
	-- -- configure dap-ui and language adapaters
	-- require('plugins.dap.ui')
	-- if vim.fn.executable('dlv') == 1 then
	--     require('plugins.dap.go')
	-- end
	-- if vim.fn.executable('gdb') == 1 then
	--     require('plugins.dap.c')
	-- end
	-- if vim.fn.executable('rust-gdb') == 1 then
	--     require('plugins.dap.rust')
	-- end
	-- require('plugins.dap.lua')
	-- require('plugins.dap.python')
end

return { "mfussenegger/nvim-dap", config = config }
