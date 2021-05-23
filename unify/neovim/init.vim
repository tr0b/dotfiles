source $HOME/.config/dotfiles/mac/neovim/init_plugins.vim " <- initialize plugins
source $HOME/.config/dotfiles/mac/neovim/mapped.vim " <- initialize mapping settings
source $HOME/.config/dotfiles/mac/neovim/general.vim " <- initialize general vim settings
source $HOME/.config/dotfiles/mac/neovim/aesthetics.vim " <- initialize aesthetics
lua require("lsp_config")
source $HOME/.config/dotfiles/mac/neovim/lsp_config.vim " <- initialize lsp settings [VIM]
" configure treesitter
