"Initialize plugins"
call plug#begin()
"LSP Tools necessary for (Neo)Vim
 Plug 'neovim/nvim-lspconfig'
 Plug 'nvim-lua/completion-nvim'
 Plug 'dense-analysis/ale'
 " UltiSnips
 Plug 'honza/vim-snippets'
 Plug 'SirVer/ultisnips'
 " Commentary, Abolish motions, repeat, surround
 Plug 'tpope/vim-commentary'
 Plug 'tpope/vim-abolish'
 Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-surround'
 " FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
 " Floaterm
 Plug 'voldikss/vim-floaterm'
 " Themes, decoration
 Plug 'itchyny/lightline.vim'
 Plug 'psliwka/vim-smoothie'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'christianchiarulli/nvcode-color-schemes.vim'
 Plug 'joshdick/onedark.vim'
call plug#end()


