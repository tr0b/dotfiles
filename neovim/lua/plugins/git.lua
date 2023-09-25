-- Git related plugins
return {
	{ 
		"kdheepak/lazygit.nvim", config = function ()
			local map = require("helpers.keys").map
			map("n", "<M-g>", ":LazyGit<CR>", "Lazy Git")
		
		end
	}, -- Lazygit
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
}
