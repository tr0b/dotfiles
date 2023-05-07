require("lspsaga").setup({})
local lspconfig = require("lspconfig") -- Imports Nvim Native LSP Client
local diagnostics = require("diagnostics") -- Import diagnostics config
local map = vim.keymap.set

local capabilities = vim.lsp.protocol.make_client_capabilities() -- LSP capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}
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
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local mappings = {
		{ "n", "gD", vim.lsp.buf.declaration, "Go to Declaration" },
		{ "n", "gd", "<cmd>Lspsaga goto_definition<CR>", "Go to Definition" },
		{ "n", "gp", "<cmd>Lspsaga peek_definition<CR>", "Peek Definition" },
		{ "n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation" },
		{ "n", "gi", "<cmd>Lspsaga lsp_finder<CR>", "Lsp Finder" },
		{ "n", "<leader>s", vim.lsp.buf.signature_help, "Signature Help" },
		{ "n", "<leader>D", vim.lsp.buf.type_definition, "Type Definition" },
		{ "n", "<leader>ln", "<cmd>Lspsaga rename ++project<CR>", "Rename" },
		{ "n", "<leader>c", "<cmd>Lspsaga code_action<CR>", "[LSP] Code Action" },
		{ "n", "<leader>r", vim.lsp.buf.references, "References" },
		{ "n", "<localleader>f", lsp_formatting, "Formatting" },
		{ "n", "<leader>ldl", "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostics" },
		{ "n", "<leader>ldb", "<cmd>Lspsaga show_buf_diagnostics<CR>", "Show Buffer Diagnostics" },
		{ "n", "<leader>ldw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Show Workspace Diagnostics" },
		{ "n", "<leader>ldc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show Cursor Diagnostics" },
		{ "n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Go To Next Diagnostic" },
		{ "n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Go To Previous Diagnostic" },
	}

	for _, m in ipairs(mappings) do
		m[3] = m[3] or m[2]
		map(m[1], m[2], m[3], { noremap = true, silent = true, buffer = bufnr, desc = m[4] })
	end
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- Automatically start coq
vim.g.coq_settings = { auto_start = "shut-up" }
local coq = require("coq")

-- Signature help
-- local signature_config = {}  -- add you config here
-- require "lsp_signature".setup(signature_config)

-- LSP virtual lines
vim.diagnostic.config({ -- disable virtual text from vim diagnostic in order to avoid redundancy
	virtual_text = false,
	virtual_lines = { only_current_line = true },
})

require("lsp_lines").setup()

-- Neodev CONFIG --
require("neodev").setup({
	library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
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

-- Mason for handling LSP,DAP,linter installs
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			coq.lsp_ensure_capabilities({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			}),
		})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["efm"] = function()
		lspconfig.efm.setup({
			on_attach = on_attach,
			flags = lsp_flags,
			init_options = { documentFormatting = true },
			settings = diagnostics.settings,
			filetypes = diagnostics.filetypes,
		})
	end,
	["clangd"] = function()
		lspconfig.clangd.setup(coq.lsp_ensure_capabilities({
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities,
		}))
	end,
	["tsserver"] = function()
		require("typescript").setup({
			disable_commands = false, -- prevent the plugin from creating Vim commands
			debug = false, -- enable debug logging for commands
			go_to_source_definition = {
				fallback = true, -- fall back to standard LSP definition on failure
			},
			server = coq.lsp_ensure_capabilities({
				init_options = { documentFormatting = false },
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			}),
		})
	end,
})
require("go").setup({
	lsp_cfg = false,
	-- other setups...
})
local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup

require("lspconfig").gopls.setup(cfg)

-- Run gofmt + goimport on save

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
	group = format_sync_grp,
})

-- Clearer golang diagnostics
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			return message
		end,
	},
}, neotest_ns)

-- Neotest setup
require("neotest").setup({
	adapters = {
		require("neotest-go")({
			dap = { justMyCode = false },
		}),
		require("neotest-jest"),
		require("neotest-rspec")({
			ignore_file_types = { "python", "vim", "lua" },
		}),
	},
})
