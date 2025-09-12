-- For conciseness
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)
-- Better window navigation
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>bd', ':bdelete!<CR>', opts) -- close buffer

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Move text up and down
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', opts)
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', opts)
-- Move text up and down
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)
vim.keymap.set('v', 'jk', '<ESC>', opts)
vim.keymap.set('v', 'kj', '<ESC>', opts)
-- open file
vim.keymap.set('n', 'gf', ':hor winc f<CR>', opts)
vim.keymap.set('n', '<leader>gf', ':vert winc f<CR>', opts)
-- copy filepath to clipboard
vim.keymap.set('n', 'yf', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
end, { silent = true, noremap = true })
-- copy pwd to clipboard
vim.keymap.set('n', 'yd', function()
  vim.fn.setreg('+', vim.fn.expand '%:p:h')
end, { silent = true, noremap = true })
-- Better terminal navigation
vim.keymap.set('t', 'jk', '<C-\\><C-n>', term_opts)
vim.keymap.set('t', '<C-Left>', '<cmd>wincmd h<CR>', term_opts)
vim.keymap.set('t', '<C-Down>', '<cmd>wincmd j<CR>', term_opts)
vim.keymap.set('t', '<C-UP>', '<cmd>wincmd k<CR>', term_opts)
vim.keymap.set('t', '<C-Right>', '<cmd>wincmd l<CR>', term_opts)
vim.keymap.set('t', '<S-x>', 'exit<CR>')
vim.keymap.set({ 't', 'n' }, '<S-x>', '<cmd>bdelete!<CR>')
-- formating
vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  require('conform').format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }
end, { desc = 'Format file or range (in visual mode)' })
-- save file without auto-formtting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)
vim.keymap.set('n', '<localLeader>d', '<cmd>:ColorizerToggle<CR>', { desc = 'Colorizer' })
-- comment/or nocomment
vim.keymap.set('n', '<localLeader>]', ':normal gcc<CR>', opts)
vim.keymap.set('v', '<localleader>]', '<Esc>:normal gvgc<CR>', { desc = '[/] Toggle comment block' })
vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { desc = 'Toggle preview changes' })
vim.keymap.set('n', '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle current changes on this line' })
