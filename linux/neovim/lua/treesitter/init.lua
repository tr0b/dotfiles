require'nvim-treesitter.configs'.setup {
	ensure_installed = 'mantained',
	highlight = { enabled = true },
	indent = { enabled = true },
	incremental_selection = {

		enabled = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm"
		}
	}
}
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
