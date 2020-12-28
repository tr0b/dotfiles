"Initialize plugins"
call plug#begin()
"NerdTree & Extras
" Plug 'scrooloose/nerdTree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
"LSP Tools necessary for (Neo)Vim
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'dense-analysis/ale'
" Plug 'ryanoasis/vim-devicons'
"Tmux navigation
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'Shougo/neosnippet.vim'
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-abolish'
" Plug 'franbach/miramare'
Plug 'hallzy/lightline-onedark'
" Plug 'honza/vim-snippets'
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'Shougo/neosnippet-snippets'
Plug 'itchyny/lightline.vim'
" Neovim LSP
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'wikitopian/hardmode'
" Plug 'nikvdp/neomux'
call plug#end()
