require 'paq' {

	'savq/paq-nvim'; -- Let Paq manage itself
	'neovim/nvim-lspconfig'; -- LSP for Nvim >= 0.5
        'ray-x/lsp_signature.nvim'; -- Asynchronous LSP signature help
        {'whynothugo/lsp_lines.nvim', url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"};
        'windwp/nvim-ts-autotag'; -- Autoclose HTML tags
        {'stevearc/dressing.nvim'}; -- some cool UI hooks for native LSP
        'lukas-reineke/indent-blankline.nvim'; -- blank line indentation (vertical line)
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}; -- Treesitter
        'm-demare/hlargs.nvim'; -- Highlight args in colour, with treesitter
        'folke/twilight.nvim'; -- dim unfocused code
	'junegunn/fzf'; -- Basic FZF
        { 'ms-jpq/coq_nvim', branch = 'coq'}; -- auto completion with coq
        { 'ms-jpq/coq.artifacts', branch = 'artifacts'}; -- snippets
        'ms-jpq/coq.thirdparty'; -- third party snippets
        'windwp/nvim-autopairs'; -- autopairs
	'junegunn/fzf.vim'; -- Other, pre-defined FZF commands
        'folke/tokyonight.nvim'; -- Colourscheme
        'akinsho/git-conflict.nvim'; -- Solve conflicts on file in a more interactive way
        'lewis6991/gitsigns.nvim'; -- Add git signs (git blame, hunk, etc)
}
