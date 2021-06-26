require 'paq-nvim' {

	'savq/paq-nvim'; -- Let Paq manage itself
	'neovim/nvim-lspconfig'; -- LSP for Nvim >= 0.5
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}; -- Treesitter
	'junegunn/fzf'; -- Basic FZF
	'junegunn/fzf.vim'; -- Other, pre-defined FZF commands
        'folke/tokyonight.nvim'; -- Colourscheme
}
