" Neovim LSP Configs
" Golang
" lua << EOF
"   require'nvim_lsp'.gopls.setup{}
"
"   Commands:
"
"   Default Values:
"     cmd = { "gopls" }
"     filetypes = { "go", "gomod" }
"     root_dir = root_pattern("go.mod", ".git")
" EOF
" Haskell
" C-family
" PHP
" Javascript
" Ruby
" SQL
" Python
" Shell (Bash) (LspInstall)
" HTML
" JSON
" Typescript
" YML
" Cmake
" Docker
" lua require("lsp")
"
" setlocal omnifunc=v:lua.vim.lsp.omnifunc
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
"LspStatus Lua side
:lua << EOF
 local nvim_lsp = require('nvim_lsp')
 local lsp_status = require('lsp-status')
 local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'diagnostic'.on_attach()
    require'completion'.on_attach()
 
    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
 
 
  end
 
  local servers = {'clangd', 'jsonls', 'sumneko_lua', 'tsserver', 'vimls', 'pyls', 'bashls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
    --require'nvim_lsp'.julials.setup{}
    require'nvim_lsp'.gopls.setup{cmd = { 'gopls', "serve" }, filetypes = { "go", "gomod" }, on_attach = on_attach, capabilities = lsp_status.capabilities}
    require'nvim_lsp'.clangd.setup{
	    cmd = { "clangd", "--background-index" },
	    filetypes = { "c", "cpp", "objc", "objcpp" }
    }
    require'nvim_lsp'.solargraph.setup{
	    cmd = { "solargraph", "stdio" },
	    filetypes = { "ruby" },
	    on_attach = on_attach
    }
	require'nvim_lsp'.hie.setup{
		capabilities = lsp_status.capabilities,
		init_options = {
			languageServerHaskell = {
			    hlintOn = true;
			    maxNumberOfProblems = 100;
			    liquidOn = true;
			    completionSnippetsOn = true;
			    formatOnImportOn = true;
			    formattingProvider = "brittany";
			    languageServerVariant = "haskell-language-server"
			  }
		},
		cmd = { "hie-wrapper", "--lsp" },
		filetypes = { "haskell" }
	}
  end
EOF
command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <buffer><silent> <leader>d <Cmd>LspShowLineDiagnostics<CR>
 
let g:diagnostic_auto_popup_while_jump = 1
 
:lua << EOF
 
    -- Haskell
    --require'nvim_lsp'.hie.setup{}
 
    --cmd = { "hie-wrapper", "--lsp" }
    --filetypes = { "haskell" }
EOF
let g:LanguageClient_serverCommands = {
        \ 'haskell': ['hie-wrapper', '--lsp'],
    \}
let g:LanguageClient_autoStart = 1
autocmd BufEnter * lua require'completion'.on_attach()
