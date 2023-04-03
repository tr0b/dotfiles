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
map('n', '<leader>w', ':w!<CR>', {noremap = true, desc = "Save current buffer (!)"}) -- write current buffer to file
map('n', '<leader>x', ':bd<CR>', {noremap = true, desc = "Close Buffer"}) -- quit current buffer
map('n', '<leader>fo', function() fzf.files() end, {noremap = true, desc = "Open File"}) -- FZF files
map('n', '<leader>fr', function() fzf.live_grep() end, {noremap = true, desc = "Live Grep (rg if possible)"}) -- Ripgrep search
map('n', '<leader>fh', function() fzf.oldfiles() end, {noremap = true, desc = "Open Old Files (History)"}) -- History search
map('n', '<leader>fb', function() fzf.buffers() end, {noremap = true, desc = "Open Buffer"}) -- Buffer search
map('n', '<leader>fgf', function() fzf.git_files() end, {noremap = true, desc = "Open Git file"}) -- Git Files search
map('n', '<leader>fgs', function() fzf.git_status() end, {noremap = true, desc = "Git Status Files"}) -- Git Status search
map('n', '<leader>fgl', function() fzf.git_commits() end, {noremap = true, desc = "Git Log Commits (Project)"}) -- Git Log commit search
map('n', '<leader>fgb', function() fzf.git_bcommits() end, {noremap = true, desc = "Git Log Commits (Buffer)"}) -- Git Log commit search
map('n', '<leader>fgs', function() fzf.git_stash() end, {noremap = true, desc = "Git Stash Files"}) -- Git Stash
map('n', '<leader>lq', ':LspInfo<CR>', {noremap = true, desc = "LSP Information"}) -- LSP References
map('n', '<leader>lr', function() fzf.lsp_references() end, {noremap = true, desc = "LSP References"}) -- LSP References
map('n', '<leader>ldf', function() fzf.lsp_definitions() end, {noremap = true, desc = "[LSP] Definitions"}) -- LSP Definitions
map('n', '<leader>ldc', function() fzf.lsp_definitions() end, {noremap = true, desc = "[LSP] Declarations"}) -- LSP Declarations
map('n', '<leader>ps', ':PaqSync<CR>', {noremap = true, desc = "Paq Sync"}) -- Paq Sync (remove, update, add packages)
map('n', '<leader>pl', ':PaqList<CR>', {noremap = true, desc = "Paq List"}) -- Paq List
map('n', '<leader>gg', ':LazyGit<CR>', {noremap = true, desc = "Lazy Git"}) -- Lazy Git
map('n', '<leader>t', '<cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', {silent = true, noremap = true, desc = "Open Terminal"}) -- Terminal
map('i', '<c-t>', '<Esc><cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', {silent = true, noremap = true, desc = "Open Terminal"}) -- Terminal
-- Zen mode keybindings

map('n', '<leader>z', ':ZenMode<CR>', {desc = "Enable Zen Mode"})

wk = require("which-key")
wk.setup({}) -- Setting up key shortcuts
wk.register({
        ["<leader>g"] = {
                name = "LazyGit",
                f = { name = "Git Files" },
                l = { name = "Git Logs" },
        },
        ["<leader>l"] = {
                name = "LSP",
                d = { name = "Definitions & Declarations" },
        },
        ["<leader>f"] = {
                name = "FZF",
                g = { name = "Git" },
        },
        ["<leader>p"] = {
                name = "Paq",
        },
})

-- Toggle term keymaps
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  map('t', '<esc>', [[<C-\><C-n>]], opts)
  map('t', 'jk', [[<C-\><C-n>]], opts)
  map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
