source $HOME/.config/nvim/init_plugins.vim " <- initialize plugins
" source $HOME/.config/nvim/lsp_config.vim " <- initialize lsp settings
source $HOME/.config/nvim/mapped.vim " <- initialize mapping settings
source $HOME/.config/nvim/general.vim " <- initialize general vim settings
source $HOME/.config/nvim/aesthetics.vim " <- initialize aesthetics

" configure treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true              -- false will disable the whole extension
  },
}
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF
lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF
