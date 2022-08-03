local cmd = vim.cmd -- Alias for vim.cmd
local map = vim.api.nvim_set_keymap -- Alias for setting keymap
-- FZF/RG command
local fzf = [[
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]]
cmd([[let mapleader=" "]]) -- Sets leaderkey to space
map('n', '<SPACE>', '<Nop>', { noremap = true }) -- nnoremap <SPACE> <Nop>
cmd([[let maplocalleader = "\\"]]) -- Sets local leader to backslash
map('n', '<leader>l', ':ls<CR>:b<space>', {noremap = true}) -- Show buffers
map('t', 'kj', [[<C-\><C-n>]], {noremap = true}) -- jk kj combination to leave term
map('t', 'jk', [[<C-\><C-n>]], {noremap = true}) -- same as above
map('i', 'kj', '<Esc>', {noremap = true}) -- Same as above, but in insert mode
map('i', 'jk', '<Esc>', {noremap = true}) -- Same as above but in Insert mode
map('n', '<leader>t', ':Twilight<CR>', {noremap = true}) -- open new term easily
map('n', '<leader>w', ':w!<CR>', {noremap = true}) -- write current buffer to file
map('n', '<leader>x', ':bd<CR>', {noremap = true}) -- quit current buffer
map('n', '<leader>f', ':Files<CR>', {noremap = true}) -- FZF files
map('n', '<leader>r', ':RG<CR>', {noremap = true}) -- Ripgrep search
map('n', '<leader>h', ':History<CR>', {noremap = true}) -- History search
map('n', '<leader>b', ':Buffers<CR>', {noremap = true}) -- Buffer search
vim.api.nvim_exec(fzf, false) -- Activate fzf/rg command

-- git-conflict keybindings --
require('git-conflict').setup({
  default_mappings = false, -- disable buffer local mapping created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  highlights = { -- They must have background color, otherwise the default color will be used
    incoming = 'DiffText',
    current = 'DiffAdd',
  },
})

vim.keymap.set('n', '<leader>co', '<Plug>(git-conflict-ours)')
vim.keymap.set('n', '<leader>ct', '<Plug>(git-conflict-theirs)')
vim.keymap.set('n', '<leader>cb', '<Plug>(git-conflict-both)')
vim.keymap.set('n', '<leader>cn', '<Plug>(git-conflict-none)')
vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
