vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap

map('n', '<leader>h', '<C-w>h', {noremap = true, silent = false})
map('n', '<leader>l', '<C-w>l', {noremap = true, silent = false})
map('n', '<leader>j', '<C-w>j', {noremap = true, silent = false})
map('n', '<leader>k', '<C-w>k', {noremap = true, silent = false})
map('i', 'jk', '<ESC>', {noremap = true, silent = false})
map('i', 'kj', '<ESC>', {noremap = true, silent = false})

map('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
map('n', '<leader>z', ':vsplit<CR>', {noremap = true, silent = true})
