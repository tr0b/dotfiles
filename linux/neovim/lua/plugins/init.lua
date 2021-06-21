require 'paq-nvim' {

	'neovim/nvim-lspconfig'; -- LSP for Nvim >= 0.5
	'nvim-lua/completion-nvim'; -- autocompletion for LSP
	'dense-analysis/ale'; -- ALE Lint/Fix diagnostics
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}; -- Treesitter
	'navarasu/onedark.nvim'; -- Colorscheme
}
