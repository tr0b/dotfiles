-- Miscelaneous fun stuff
return {
	-- Comment with haste
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	-- Move stuff with <M-j> and <M-k> in both normal and visual mode
	{
		"echasnovski/mini.move",
		config = function()
			require("mini.move").setup()
		end,
	},
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround", -- Surround stuff with the ys-, cs-, ds- commands
	"tpope/vim-abolish", -- Vim abolish. Contains Subvert and is very helpful
}
