" " Show errors after 1 second
set updatetime=500
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1
" " Complete parentheses for functions
let g:completion_enable_auto_paren = 1
" " Work with endwise
" let g:completion_confirm_key = "\<C-y>"
" Set completeopt to have a better completion experience
set completeopt=longest,menuone,noinsert,noselect
" Avoid showing message extra message when using completion
" set shortmess+=c
let g:completion_enable_snippet = 'UltiSnips'
 
let g:netrw_gx = '<cWORD>'
" autocmd BufEnter * lua require'completion'.on_attach()
" :lua << EOF
"   local on_attach = function()
"   require'completion'.on_attach()
"   require'diagnostic'.on_attach()
" end
" set statusline+=\ %{LspStatus()}
" EOF
"LspStatus vimscript side
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction
command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <buffer><silent> <leader>d <Cmd>LspShowLineDiagnostics<CR>
 
let g:diagnostic_auto_popup_while_jump = 1
 
autocmd BufEnter * lua require'completion'.on_attach()
