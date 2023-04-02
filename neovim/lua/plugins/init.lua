require 'paq' {
	'savq/paq-nvim'; -- Let Paq manage itself
	'neovim/nvim-lspconfig'; -- LSP for Nvim >= 0.5
	'nvim-tree/nvim-web-devicons'; -- Neovim web dev icons for patched fonts
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}; -- Treesitter
	{'NvChad/nvim-colorizer.lua', run = function() require('colorizer').setup() end}; -- Colorizer (e.g. for CSS colors)
        {'glepnir/lspsaga.nvim', run = function() require("lspsaga").setup() end}; -- LSP Saga
        {'ibhagwan/fzf-lua', branch = 'main'}; -- Lua FZF
        'folke/which-key.nvim', -- Shortcut guide
        'sindrets/diffview.nvim'; -- Diffview -- Key shortcuts
        'kdheepak/lazygit.nvim'; -- Lazygit
        {'whynothugo/lsp_lines.nvim', url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"};
        'lukas-reineke/indent-blankline.nvim'; -- blank line indentation (vertical line)
        'folke/twilight.nvim'; -- dim unfocused code
        'folke/zen-mode.nvim'; -- Zen mode & twilight for improved focus
        { 'ms-jpq/coq_nvim', branch = 'coq'}; -- auto completion with coq
        { 'ms-jpq/coq.artifacts', branch = 'artifacts'}; -- snippets
        'ms-jpq/coq.thirdparty'; -- third party snippets
        'windwp/nvim-autopairs'; -- autopairs
        'windwp/nvim-ts-autotag'; -- autotags
        'rebelot/kanagawa.nvim'; -- Colourscheme
        'lewis6991/gitsigns.nvim'; -- Add git signs (git blame, hunk, etc)
        'nvim-lua/plenary.nvim'; -- organizing my life with neorg
        'Abstract-IDE/penvim'; -- organizing my life with neorg
        'Bekaboo/deadcolumn.nvim'; -- Dynamic, color columns
}
