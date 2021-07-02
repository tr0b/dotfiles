local ts = require 'nvim-treesitter.configs' -- Import Treesitter

ts.setup {
	ensure_installed = 'all',
        ignore_install = { 'haskell' },
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {

		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm"
		}
	}
} 
--
-- Treesitter folding
vim.api.nvim_exec([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]], true)
