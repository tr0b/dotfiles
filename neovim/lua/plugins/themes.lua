-- Themes
return {
	"folke/tokyonight.nvim",
	{
		"norcalli/nvim-colorizer.lua", config = function()
			require'colorizer'.setup()
		end
	},
	{
		"lukas-reineke/virt-column.nvim", config = function()
			require'virt-column'.setup( { char = "┃" } )
		end
	}
}
