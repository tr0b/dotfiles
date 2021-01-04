"Initialize plugins"
call plug#begin()
"LSP Tools necessary for (Neo)Vim
 Plug 'neovim/nvim-lsp'
 Plug 'nvim-lua/completion-nvim'
 Plug 'nvim-lua/lsp-status.nvim'
 Plug 'nvim-lua/diagnostic-nvim'
 Plug 'dense-analysis/ale'
 Plug 'ryanoasis/vim-devicons'
"Tmux navigation
 Plug 'christoomey/vim-tmux-navigator'
 " Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
 Plug 'tpope/vim-repeat'
 " UltiSnips
 Plug 'SirVer/ultisnips'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'preservim/nerdcommenter'
 Plug 'tpope/vim-abolish'
 Plug 'itchyny/lightline.vim'
 Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
 Plug 'psliwka/vim-smoothie'
 Plug 'nvim-treesitter/nvim-treesitter'
 Plug 'morhetz/gruvbox'
 Plug 'shinchu/lightline-gruvbox.vim'
 Plug 'wikitopian/hardmode'
 Plug 'andys8/vim-elm-syntax'
call plug#end()
