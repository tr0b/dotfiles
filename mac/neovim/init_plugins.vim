"Initialize plugins"
call plug#begin()
"LSP Tools necessary for (Neo)Vim
 Plug 'neovim/nvim-lspconfig'
 Plug 'nvim-lua/completion-nvim'
 Plug 'dense-analysis/ale'
"Tmux navigation
 Plug 'tpope/vim-repeat'
 " UltiSnips
 Plug 'honza/vim-snippets'
 Plug 'SirVer/ultisnips'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'preservim/nerdcommenter'
 Plug 'tpope/vim-abolish'
 Plug 'itchyny/lightline.vim'
 Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
 Plug 'psliwka/vim-smoothie'
 Plug 'nvim-treesitter/nvim-treesitter'
 Plug 'wikitopian/hardmode'
 Plug 'andys8/vim-elm-syntax'
 Plug 'christianchiarulli/nvcode-color-schemes.vim'
 Plug 'joshdick/onedark.vim'
call plug#end()
