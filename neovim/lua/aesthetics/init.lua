vim.o.background = 'dark' -- Dark background, useful for transparency options
vim.o.termguicolors = true -- termguicolors (256 colour)
vim.o.colorcolumn = '80' -- 80 char limit for columns
vim.o.conceallevel = 3 -- MARKDOWN conceal level
-- Regardless of colorscheme, highlight should have no bg, fg in gui
vim.api.nvim_exec([[au ColorScheme * hi Normal ctermbg=none guibg=none]], false)
-- Regardless of colorscheme, lines should have no bg, fg in gui
vim.api.nvim_exec([[au ColorScheme * hi LineNr ctermbg=NONE guibg=NONE]], false)
vim.cmd[[colorscheme tokyonight]]

vim.api.nvim_exec([[
  call sign_define("LspDiagnosticsSignError", {"text" : "✗", "texthl" : "LspDiagnosticsError"})
  call sign_define("LspDiagnosticsSignWarning", {"text" : "", "texthl" : "LspDiagnosticsWarning"})
  call sign_define("LspDiagnosticsSignInformation", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
  call sign_define("LspDiagnosticsSignHint", {"text" : "", "texthl" : "LspDiagnosticsHint"})
]], true)

local signs = { Error = "×", Warn = " ", Hint = "", Info = "¡" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
