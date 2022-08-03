local lspconfig = require('lspconfig') -- Imports Nvim Native LSP Client
local diagnostics = require('diagnostics') -- Import diagnostics config

local capabilities = vim.lsp.protocol.make_client_capabilities() -- LSP capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<localleader>[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<localleader>]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, opts)

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use efm)
            return client.name == "efm"
        end,
        bufnr = bufnr,
        async = true,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
              lsp_formatting(bufnr)
          end,
      })
  end
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<localleader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<localleader>r', vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", '<localleader>p', lsp_formatting, bufopts)
  vim.keymap.set("n", '<leader>p', vim.lsp.buf.range_formatting, bufopts)

end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local system_name -- Determine OS
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

------------ LUA LANGUAGE SERVER PROTOCOL CONFIGURATION ----------------------
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Automatically start coq
vim.g.coq_settings = { auto_start = 'shut-up' }

local coq = require('coq')

lspconfig['sumneko_lua'].setup(coq.lsp_ensure_capabilities( {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        --.setup(coq.lsp_ensure_capabilities( your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}))

------------ ELIXIR LANGUAGE SERVER PROTOCOL CONFIGURATION -------------------
lspconfig['elixirls'].setup(coq.lsp_ensure_capabilities( {
  path = '/home/thomas/.local/bin/elixir-ls/language_server.sh',
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}))

------------ GENERIC DIAGNOSTICS LSP (FORMATTING, LINTING) -------------------
lspconfig['efm'].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        init_options = {documentFormatting = true},
        settings = diagnostics.settings,
        filetypes = diagnostics.filetypes
}

local servers = { 'tsserver', 'sonls', 'phpactor', 'bashls', 'clangd' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
    -- on_attach = my_custom_on_attach,
  }))
end
-- Signature help
local signature_config = {}  -- add you config here
require "lsp_signature".setup(signature_config)

-- LSP virtual lines
vim.diagnostic.config({ -- disable virtual text from vim diagnostic in order to avoid redundancy
  virtual_text = false,
  virtual_lines = { only_current_line = true },
})

require("lsp_lines").setup()
