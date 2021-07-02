"Aesthetics config
" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ }
set noshowmode
let g:nvcode_termcolors=256
colorscheme aurora
set background=dark
au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme * hi LineNr ctermbg=NONE guibg=NONE
set termguicolors
" au ColorScheme palenight hi Normal ctermbg=red guibg=red
" Italics 
let g:palenight_terminal_italics=1
" set background=dark
" let g:one_allow_italics = 1
" colorscheme one
" let g:airline_theme = 'one'
" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE
" colorscheme nord
" NERDTree icons
set colorcolumn=80
set conceallevel=3
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "",
    \ "Staged"    : "",
    \ "Untracked" : "",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "",
    \ "Dirty"     : "✘ ", 
    \ "Clean"     : "",
    \ 'Ignored'   : '',
    \ "Unknown"   : "?"
    \ }
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [[], ['fileencoding']]
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': [[]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'mode_map':{
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
      \ },
      \ }
"ALE Prettier set use of single quotes
let g:prettier#config#single_quote = 'true'

" sign define LspDiagnosticsErrorSign text=✗
" sign define LspDiagnosticsWarningSign text=
" sign define LspDiagnosticsInformationSign text=
" sign define LspDiagnosticsHintSign text=
call sign_define("LspDiagnosticsErrorSign", {"text" : "✗", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticHintSign", {"text" : "", "texthl" : "LspDiagnosticsHint"})
" configure treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
set guifont=DejaVu\ Sans\ Mono\ 13
