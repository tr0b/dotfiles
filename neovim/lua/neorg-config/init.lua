local neorg = require("neorg")

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/work",
				},
			},
		},
		["core.concealer"] = {},
		["core.journal"] = {},
	},
})
