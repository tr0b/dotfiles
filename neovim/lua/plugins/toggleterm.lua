return {
	"akinsho/toggleterm.nvim",
	config = function()
		-- ToggleTerm config
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],
			direction = "float",
			close_on_exit = true,
		})
		local map = require("helpers.keys").map
		map("n", "<leader>t", '<cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', "Open Terminal")
		map("i", "<c-t>", '<Esc><cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', "Open Terminal")
	end,
}
