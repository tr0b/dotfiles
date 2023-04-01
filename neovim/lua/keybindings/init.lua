local cmd = vim.cmd -- Alias for vim.cmd
local map = vim.keymap.set -- Alias for setting keymap
local fzf = require('fzf-lua')
-- FZF/RG command
cmd([[let mapleader=" "]]) -- Sets leaderkey to space
map('n', '<SPACE>', '<Nop>', { noremap = true }) -- nnoremap <SPACE> <Nop>
cmd([[let maplocalleader = "\\"]]) -- Sets local leader to backslash
map('n', '<leader>l', ':ls<CR>:b<space>', {noremap = true}) -- Show buffers
map('t', 'kj', [[<C-\><C-n>]], {noremap = true}) -- jk kj combination to leave term
map('t', 'jk', [[<C-\><C-n>]], {noremap = true}) -- same as above
map('i', 'kj', '<Esc>', {noremap = true}) -- Same as above, but in insert mode
map('i', 'jk', '<Esc>', {noremap = true}) -- Same as above but in Insert mode
map('n', '<leader>t', ':Twilight<CR>', {noremap = true, desc = "Enable Twilight"}) -- open new term easily
map('n', '<leader>w', ':w!<CR>', {noremap = true, desc = "Save current buffer (!)"}) -- write current buffer to file
map('n', '<leader>x', ':bd<CR>', {noremap = true, desc = "Close Buffer"}) -- quit current buffer
map('n', '<leader>f', function() fzf.files() end, {noremap = true, desc = "Open File"}) -- FZF files
map('n', '<leader>r', function() fzf.live_grep() end, {noremap = true, desc = "Live Grep (rg if possible)"}) -- Ripgrep search
map('n', '<leader>h', function() fzf.oldfiles() end, {noremap = true, desc = "Open Old Files (History)"}) -- History search
map('n', '<leader>b', function() fzf.buffers() end, {noremap = true, desc = "Open Buffer"}) -- Buffer search
map('n', '<leader>gff', function() fzf.git_files() end, {noremap = true, desc = "Open Git file"}) -- Git Files search
map('n', '<leader>gfs', function() fzf.git_status() end, {noremap = true, desc = "Git Status Files"}) -- Git Status search
map('n', '<leader>glp', function() fzf.git_commits() end, {noremap = true, desc = "Git Log Commits (Project)"}) -- Git Log commit search
map('n', '<leader>glb', function() fzf.git_bcommits() end, {noremap = true, desc = "Git Log Commits (Buffer)"}) -- Git Log commit search
map('n', '<leader>gs', function() fzf.git_stash() end, {noremap = true, desc = "Git Stash Files"}) -- Git Stash
map('n', '<leader>lr', function() fzf.lsp_references() end, {noremap = true, desc = "LSP References"}) -- LSP References
map('n', '<leader>ldf', function() fzf.lsp_definitions() end, {noremap = true, desc = "[LSP] Definitions"}) -- LSP Definitions
map('n', '<leader>ldc', function() fzf.lsp_definitions() end, {noremap = true, desc = "[LSP] Declarations"}) -- LSP Declarations
map('n', '<leader>lca', function() fzf.lsp_code_actions() end, {noremap = true, desc = "[LSP] Code Actions"}) -- LSP Code Actions
-- Zen mode keybindings

map('n', '<leader>z', ':ZenMode<CR>', {desc = "Enable Zen Mode"})
