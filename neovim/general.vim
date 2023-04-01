"Initial config
set shellcmdflag=-ic
set clipboard=unnamed,unnamedplus
" Set hidden buffers
:set hid
filetype off
filetype plugin indent on
syntax on
set number
set relativenumber
"tmux-vim options
set splitbelow
set splitright
let g:tmux_navigator_disable_when_zoomed = 1
"256 colour
set t_Co=256
"NERDTree options
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
:vmap <Leader>. <plug>NERDCommenterUncomment
:nmap <Leader>. <plug>NERDCommenterUncomment
:vmap <Leader><Leader> <plug>NERDCommenterSexy
:nmap <Leader><Leader> <plug>NERDCommenterSexy
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-K>     <Plug>(neosnippet_expand_or_jump)
smap <C-K>     <Plug>(neosnippet_expand_or_jump)
xmap <C-K>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif
" fzf+ripgrep search-term config with :Find command
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
au BufRead,BufNewFile *.json set filetype=json
hi SpellBad term=reverse ctermbg=darkgreen
autocmd StdinReadPre * let s:std_in=1
"gopls goinfomode
let g:go_info_mode='gopls'
"asyncomplete settings
" let g:asyncomplete_auto_popup = 1
let g:UltiSnipsExpandTrigger = "<NUL>"
let g:UltiSnipsJumpForwardTrigger="<NUL>"
let g:UltiSnipsJumpBackwardTrigger="<NUL>"
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '!'
" Fix files with prettier, and then ESLint.
let g:prettier#config#print_width = 80
let g:ale_linters = {
\   'javascript': ['eslint','prettier'],
\   'ruby': ['rubocop'],
\}
let g:airline#extensions#ale#enabled = 1
" let g:ale_sign_column_always = 1
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

set ignorecase
set smartcase
" Set indent folds
set foldmethod=indent   
" set foldnestmax=10
set nofoldenable
" set foldlevel=2
" Persistent undo
set undofile
let g:python3_host_prog="/usr/bin/python3.9"

" Neovim term configs
  augroup neovim_terminal
    autocmd!

    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen,TermEnter * startinsert

    " Disables number lines on terminal buffers
    autocmd TermOpen,TermEnter * :set nonumber norelativenumber
    " Enables number lines when entering non term buffer
    autocmd BufEnter,TermLeave * :set number relativenumber

autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Neovim/GIT Remote Initial Integration
if has('nvim')
  let $GIT_EDITOR = 'nvr --remote-wait'
endif
