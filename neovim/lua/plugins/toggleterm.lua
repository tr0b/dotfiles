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
		-- Toggle term keymaps
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		end
		vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
	end,
}
