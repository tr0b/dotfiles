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
map('n', 'kj', '<Esc>', {noremap = true}) -- s.a.a, but in normal mode
map('n', 'jk', '<Esc>', {noremap = true}) -- s.a.a
map('n', '<leader>t', ':term<CR>', {noremap = true}) -- open new term easily
map('n', '<leader>w', ':w!<CR>', {noremap = true}) -- write current buffer to file
map('n', '<leader>x', ':bd<CR>', {noremap = true}) -- quit current buffer
map('n', '<leader>f', ':Files<CR>', {noremap = true}) -- FZF files
map('n', '<leader>r', ':RG<CR>', {noremap = true}) -- Ripgrep search
map('n', '<leader>h', ':History<CR>', {noremap = true}) -- History search
map('n', '<leader>b', ':Buffers<CR>', {noremap = true}) -- Buffer search
vim.api.nvim_exec(fzf, false) -- Activate fzf/rg command

