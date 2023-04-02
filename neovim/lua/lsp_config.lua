local nvim_lsp = require('nvim_lsp')
local lsp_status = require('lsp-status')
local on_attach = function(_, bufnr)
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
require'completion'.on_attach()

-- Mappings.
local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

local servers = {'clangd', 'jsonls', 'sumneko_lua', 'tsserver', 'vimls', 'solargraph', 'bashls', 'jedi_language_server', 'elmls', 'intelephense', 'diagnosticls', 'cssls'}
for _, lsp in ipairs(servers) do
nvim_lsp[lsp].setup {
on_attach = on_attach,
}
--require'nvim_lsp'.julials.setup{}
require'nvim_lsp'.clangd.setup{
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" }
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

capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}
end
