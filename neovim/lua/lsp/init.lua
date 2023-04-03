require("lspsaga").setup({})
local lspconfig = require('lspconfig') -- Imports Nvim Native LSP Client
local diagnostics = require('diagnostics') -- Import diagnostics config
local keymap = vim.keymap.set

local capabilities = vim.lsp.protocol.make_client_capabilities() -- LSP capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

keymap('n', '<leader>ldl', "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show Line Diagnostics", })
keymap('n', '<leader>ldb',  "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "Show Buffer Diagnostics", })
keymap('n', '<leader>ldw', "<cmd>Lspsaga show_workspace_diagnostics<CR>", { desc = "Show Workspace Diagnostics", })
keymap('n', '<leader>ldc', "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show Cursor Diagnostics", })
keymap('n', '<localleader>[', "<cmd>Lspsaga diagnostic_jump_prev<CR>", { noremap=true, silent=true, desc = "Go To Next Diagnostic", })
keymap('n', '<localleader>]', "<cmd>Lspsaga diagnostic_jump_next<CR>", { noremap=true, silent=true, desc = "Go To Previous Diagnostic", })

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
  keymap('n', 'lgD', vim.lsp.buf.declaration, {noremap=true, silent=true, buffer=bufnr, desc="Go to Declaratio"})
  keymap('n', 'lgd',"<cmd>Lspsaga goto_definition<CR>", {noremap=true, silent=true, buffer=bufnr, desc="Go to Definition"})
  keymap('n', 'lpd', "<cmd>Lspsaga peek_definition<CR>", {noremap=true, silent=true, buffer=bufnr, desc="Peek Definition"})
  keymap('n', 'K', "<cmd>Lspsaga hover_doc<CR>", {noremap=true, silent=true, buffer=bufnr, desc="Hover Documentation"})
  keymap('n', 'gi', "<cmd> Lspsaga lsp_finder<CR>", {noremap=true, silent=true, buffer=bufnr, desc="Lsp Finder"})
  keymap('n', '<localleader>k', vim.lsp.buf.signature_help, bufopts)
  keymap('n', '<leader>D', vim.lsp.buf.type_definition, {noremap=true, silent=true, buffer=bufnr, desc="Type Definition"})
  keymap('n', '<leader>ln', "<cmd>Lspsaga rename ++project<CR>", {noremap=true, silent=true, buffer=bufnr, desc="Rename"})
  keymap('n', '<leader>lc',  "<cmd>Lspsaga code_action<CR>", {noremap=true, silent=true, buffer=bufnr, desc="[LSP] Code Action"})
  keymap('n', '<localleader>r', vim.lsp.buf.references, bufopts)
  keymap("n", '<localleader>p', lsp_formatting, bufopts)
  keymap("n", '<leader>p', vim.lsp.buf.format, bufopts)


end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Automatically start coq
vim.g.coq_settings = { auto_start = 'shut-up' }
local coq = require('coq')
------------ LUA LANGUAGE SERVER PROTOCOL CONFIGURATION ----------------------

lspconfig['lua_ls'].setup(coq.lsp_ensure_capabilities({
  filetypes = { "lua" },
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabalities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
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

local servers = { 'tsserver', 'phpactor', 'bashls', 'clangd' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
    -- on_attach = my_custom_on_attach,
  }))
end
-- Signature help
-- local signature_config = {}  -- add you config here
-- require "lsp_signature".setup(signature_config)

-- LSP virtual lines
vim.diagnostic.config({ -- disable virtual text from vim diagnostic in order to avoid redundancy
  virtual_text = false,
  virtual_lines = { only_current_line = true },
})

require("lsp_lines").setup()

-- DAP CONFIG --
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
