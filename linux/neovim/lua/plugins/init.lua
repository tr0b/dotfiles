require 'paq-nvim' {

	'savq/paq-nvim'; -- Let Paq manage itself
	'neovim/nvim-lspconfig'; -- LSP for Nvim >= 0.5
        'hrsh7th/nvim-compe'; -- Lua Nvim auto-completion
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}; -- Treesitter
	'junegunn/fzf'; -- Basic FZF
	'junegunn/fzf.vim'; -- Other, pre-defined FZF commands
        'folke/tokyonight.nvim'; -- Colourscheme
}
