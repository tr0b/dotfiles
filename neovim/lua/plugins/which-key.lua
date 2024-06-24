return {
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.register({
				["<leader>"] = {
					u = { name = "UI" },
					t = { name = "Trouble" },
					d = { name = "Debugging" },
					g = { name = "Git" },
				},
			})
		end,
	},
}
