-- Set up cool signs for diagnostics
local signs = { Error = "✗", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- Diagnostic config
local diagnostic_config = {
	virtual_text = false,
	virtual_lines = { only_current_line = true },
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}
-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	local lsp_map = require("helpers.keys").lsp_map

	lsp_map("<M-r>", "<cmd>Lspsaga rename<CR>", bufnr, "Rename symbol")
	lsp_map("<M-a>", "<cmd>Lspsaga code_action<CR>", bufnr, "Code action")
	lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
	lsp_map("<leader>lo", "<cmd>Lspsaga outline<CR>", bufnr, "Outline")
	lsp_map("K", "<cmd>Lspsaga hover_doc<CR>", bufnr, "Hover Documentation")

	lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
	lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "Goto References")
	lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
	lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
	lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")

	-- Attach and configure vim-illuminate
	require("illuminate").on_attach(client)
end

-- LSP Configuration & Plugins
return {
	{ "whynothugo/lsp_lines.nvim", url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
			"RRethy/vim-illuminate",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Set up Mason before anything else
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pylsp",
					"gopls",
					"html",
					"intelephense",
					"ember",
					"ltex",
					"yamlls",
					"clangd",
					"elixirls",
					"cssls",
					"bashls",
					"dockerls",
				},
				automatic_installation = true,
			})

			-- Quick access via keymap
			require("helpers.keys").map("n", "<leader>m", "<cmd>Mason<cr>", "Show Mason")

			-- Neodev setup before LSP config
			require("neodev").setup()

			-- Turn on LSP status information
			require("fidget").setup()

			vim.diagnostic.config(diagnostic_config)
			require("lsp_lines").setup()

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				["tsserver"] = function()
					require("typescript-tools").setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,

				["gopls"] = function() end,
				["lua_ls"] = function()
					require("lspconfig")["lua_ls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.stdpath("config") .. "/lua"] = true,
									},
								},
							},
						},
					})
				end,
				["pylsp"] = function()
					require("lspconfig")["pylsp"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							pylsp = {
								plugins = {
									flake8 = {
										enabled = true,
										maxLineLength = 88, -- Black's line length
									},
									-- Disable plugins overlapping with flake8
									pycodestyle = {
										enabled = false,
									},
									mccabe = {
										enabled = false,
									},
									pyflakes = {
										enabled = false,
									},
									-- Use Black as the formatter
									autopep8 = {
										enabled = false,
									},
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		"ray-x/go.nvim",
		ft = "go",
		config = function()
			require("go").setup({
				lsp_cfg = true,
				goimport = "gopls", -- goimport command, can be gopls[default] or goimport
				lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
				lsp_on_attach = on_attach, -- use on_attach from go.nvim
				lsp_diag_virtual_text = false,
				luasnip = true,
				lsp_inlay_hints = {
					parameter_hints_prefix = "󰊕",
				},
				diagnostic = diagnostic_config,
			})
			local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup
			require("lspconfig").gopls.setup(cfg)
			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
			vim.diagnostic.config(diagnostic_config)
		end,
		lazy = true,
	},
}
