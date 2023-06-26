local ts = require("nvim-treesitter.configs") -- Import Treesitter

ts.setup({
	autotag = { enable = true },
	ensure_installed = "all",
	ignore_install = { "haskell" },
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	indent = { enable = true },
	incremental_selection = {

		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})

-- Treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- Highlight args with treesitter
require("hlargs").setup()
