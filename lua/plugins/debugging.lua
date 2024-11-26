return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")
		local mason_registry = require("mason-registry")

		require("dapui").setup()
		require("dap-go").setup()

		-- Set up Python
		require("dap-python").setup("python")

		-- Set up JavaScript
		dap.adapters.node2 = {
			type = "executable",
			command = "node",
			args = {
				mason_registry.get_package("node-debug2-adapter"):get_install_path() .. "/out/src/nodeDebug.js",
			},
		}

		-- Set up C/C++
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = mason_registry.get_package("cpptools"):get_install_path()
				.. "/extension/debugAdapters/bin/OpenDebugAD7",
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true, -- Changed to true to help with debugging
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
				MIMode = "gdb", -- Added explicit GDB configuration
				miDebuggerPath = "/usr/bin/gdb", -- Specify GDB path
			},
		}

		-- Use the same configuration for C
		dap.configurations.c = dap.configurations.cpp

		-- Rest of your configurations remain the same...
		-- Keybindings
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>db", dap.run_to_cursor)
		vim.keymap.set("n", "<space>?", function()
			require("dapui").eval(nil, { enter = true })
		end)
		vim.keymap.set("n", "<F2>", dap.continue)
		vim.keymap.set("n", "<F3>", dap.step_into)
		vim.keymap.set("n", "<F4>", dap.step_over)
		vim.keymap.set("n", "<F5>", dap.step_out)
		vim.keymap.set("n", "<F6>", dap.step_back)
		vim.keymap.set("n", "<F12>", dap.restart)

		-- Auto open/close dap-ui
		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
