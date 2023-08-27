return {
	{
		"ray-x/go.nvim",
		ft = "go",
		config = function()
			require("go").setup({
				lsp_cfg = true,
				goimport = "gopls", -- goimport command, can be gopls[default] or goimport
				lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
				lsp_on_attach = require("lsp.on_attach").setup, -- use on_attach from go.nvim
				lsp_diag_virtual_text = false,
				luasnip = true,
				lsp_inlay_hints = {
					parameter_hints_prefix = "󰊕",
				},
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
		end,
		lazy = true,
	},
}
