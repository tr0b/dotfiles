local null_ls = require("null-ls")
local M = {
	sources = {
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.gofumpt,
		-- null_ls.builtins.formatting.goimports_reviser,
		-- null_ls.builtins.formatting.golines,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.phpstan,
		null_ls.builtins.formatting.phpcsfixer,
		-- null_ls.builtins.completion.spell,
	},
}
return M
