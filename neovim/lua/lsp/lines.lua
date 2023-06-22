-- LSP virtual lines
vim.diagnostic.config({ -- disable virtual text from vim diagnostic in order to avoid redundancy
	virtual_text = false,
	virtual_lines = { only_current_line = true },
})

require("lsp_lines").setup()
