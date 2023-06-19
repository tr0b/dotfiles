-- Neodev CONFIG --
require("neodev").setup({
	library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Neotest setup
require("neotest").setup({
	adapters = {
		require("neotest-go")({
			dap = { justMyCode = false },
		}),
		require("neotest-jest"),
		require("neotest-rspec")({
			ignore_file_types = { "python", "vim", "lua" },
		}),
	},
	status = {
		enabled = true,
		signs = true,
		virtual_text = true,
	},
})

-- Clearer golang diagnostics
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			return message
		end,
	},
}, neotest_ns)
