local keymap = vim.keymap

local opts = { noremap = true, silent = true }
local function with_desc(desc)
  return vim.tbl_extend('force', opts, { desc = desc })
end
-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- Disable the spacebar key's default behavior in Normal and Visual modes
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

keymap.set('n', 'x', '"_x', with_desc 'delete single character')

keymap.set('n', '<C-d>', '<C-d>zz', with_desc 'scroll and center')
keymap.set('n', '<C-u>', '<C-u>zz', with_desc 'scroll and center')

keymap.set('n', 'n', 'nzzzv', with_desc 'find and center')
keymap.set('n', 'N', 'Nzzzv', with_desc 'find and center')

keymap.set('n', '<C-Up>', ':resize -2<CR>', with_desc 'decrease window heigth')
keymap.set('n', '<C-Down>', ':resize +2<CR>', with_desc 'increase window heigth')
keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', with_desc 'decrease window width')
keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', with_desc 'increase window width')

keymap.set('n', '<C-k>', '<C-w>k', with_desc 'navigate up')
keymap.set('n', '<C-j>', '<C-w>j', with_desc 'navigation down')
keymap.set('n', '<C-h>', '<C-w>h', with_desc 'navigation left')
keymap.set('n', '<C-l>', '<C-w>l', with_desc 'navigation rigth')

keymap.set('n', '<Tab>', ':bnext<CR>', with_desc 'buffer next')
keymap.set('n', '<S-Tab>', ':bprevious<CR>', with_desc 'buffer previous')
keymap.set('n', '<leader>bd', ':bdelete!<CR>', with_desc 'close buffer')

keymap.set('n', '<leader>to', ':tabnew<CR>', with_desc 'open new tab')
keymap.set('n', '<leader>tx', ':tabclose<CR>', with_desc 'close current tab')
keymap.set('n', '<leader>tn', ':tabn<CR>', with_desc 'go to next tab')
keymap.set('n', '<leader>tp', ':tabp<CR>', with_desc 'go to previous tab')

keymap.set('v', '<', '<gv', with_desc 'remove indent ')
keymap.set('v', '>', '>gv', with_desc 'tab indent')

keymap.set('v', 'p', '"_dP', with_desc 'paste')

keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = { border = 'rounded', max_width = 100 } }
end, with_desc 'Go to previous diagnostic message')

keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = { border = 'rounded', max_width = 100 } }
end, with_desc 'Go to next diagnostic message')

keymap.set('n', '<leader>df', function()
  vim.diagnostic.open_float(nil, { border = 'rounded', max_width = 100 })
end, with_desc 'Open floating diagnostic message')
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, with_desc 'Open diagnostics list')

keymap.set('n', '<A-k>', ':m .-2<CR>==', with_desc 'Move line up')
keymap.set('n', '<A-j>', ':m .+1<CR>==', with_desc 'Move line down')

keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", with_desc 'Move selection up')
keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", with_desc 'Move selection down')

keymap.set('i', 'jk', '<ESC>', with_desc 'exit insert mode')
keymap.set('i', 'kj', '<ESC>', with_desc 'exit insert mode')
keymap.set('v', 'jk', '<ESC>', with_desc 'exit insert mode')
keymap.set('v', 'kj', '<ESC>', with_desc 'exit insert mode')

keymap.set('n', 'gf', ':hor winc f<CR>', with_desc 'Open file under cursor split')
keymap.set('n', '<leader>gf', ':vert winc f<CR>', with_desc 'Open file under cursor vsplit')

keymap.set('n', 'yf', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
end, with_desc 'copy file path to clipboard')

keymap.set('n', 'yd', function()
  vim.fn.setreg('+', vim.fn.expand '%:p:h')
end, with_desc 'copy pwd to clipboard')

keymap.set('t', 'jk', '<C-\\><C-n>', with_desc 'to normal mode')
keymap.set('t', '<C-h>', '<cmd>wincmd h<CR>', with_desc 'Move to left window')
keymap.set('t', '<C-j>', '<cmd>wincmd j<CR>', with_desc 'Move to down window')
keymap.set('t', '<C-k>', '<cmd>wincmd k<CR>', with_desc 'Move to up window')
keymap.set('t', '<C-l>', '<cmd>wincmd l<CR>', with_desc 'Move to right window')
keymap.set('t', '<S-x>', 'exit<CR>', with_desc 'exit terminal')
keymap.set({ 't', 'n' }, '<S-x>', '<cmd>bdelete!<CR>', with_desc 'exit/delete buffer')

keymap.set({ 'n', 'v' }, '<leader>cf', function()
  require('conform').format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }
end, with_desc 'Format file or range')

keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', with_desc 'save file without auto-formtting')
keymap.set('n', '<localLeader>d', '<cmd>:ColorizerToggle<CR>', { desc = 'Colorizer' })

keymap.set('n', '<localLeader>]', ':normal gcc<CR>', with_desc())
keymap.set('v', '<localleader>]', '<Esc>:normal gvgc<CR>', with_desc "[/] Toggle comment block'")
keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', with_desc 'Toggle preview changes')
keymap.set('n', '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>', with_desc 'Toggle current changes on this line')
keymap.set('v', '//', 'y/<C-R>"<CR>', with_desc 'Search for highlighted text')
keymap.set('n', '<leader>j', '*``cgn', with_desc 'Replace word under curser')
