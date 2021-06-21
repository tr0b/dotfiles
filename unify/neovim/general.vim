"Initial config
" set shellcmdflag=-ic
set clipboard^=unnamed,unnamedplus
" Optimize macros
set lazyredraw 
" Set hidden buffers
:set hid
filetype off
filetype plugin indent on
syntax on
" Set relative numbers
set number
set relativenumber
" set smart case
set ignorecase
set smartcase
" Set indent folds
set foldmethod=indent   
" set foldnestmax=10
set nofoldenable
" set foldlevel=2
" Persistent undo
set undofile
" Ruler
set ruler
" Live substitution replacement
set inccommand=nosplit
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
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
hi SpellBad term=reverse ctermbg=darkgreen
autocmd StdinReadPre * let s:std_in=1
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
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:python3_host_prog="/usr/local/bin/python3"

" Neovim term configs
  augroup neovim_terminal
    autocmd!

    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen,TermEnter * startinsert

    " Disables number lines on terminal buffers
    autocmd TermOpen,TermEnter * :set nonumber norelativenumber
    " Enables number lines when entering non term buffer
    autocmd BufEnter,TermLeave * :set number relativenumber
  augroup END
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" make nvr git editor
if has('nvim')
  let $GIT_EDITOR = 'nvr --remote-wait'
endif

