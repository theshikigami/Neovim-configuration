-- lua/mazen/core/keymaps.lua

local map = vim.keymap.set

-- Recommended: use jk or kj to exit insert mode quickly
map('i', 'jk', '<ESC>', { desc = 'Exit Insert Mode' })
map('i', 'kj', '<ESC>', { desc = 'Exit Insert Mode' })

-- Clear search highlights
map('n', '<leader>n', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Terminal mappings (if you use Neovim's terminal)
map('t', '<ESC><ESC>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })
map('t', '<C-w>', '<C-\\><C-n><C-w>', { desc = 'Move window' }) -- Allows window navigation in terminal

-- Basic window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

-- Quickfix list navigation (useful for errors/warnings)
map('n', '[q', ':cprev<CR>', { desc = 'Previous Quickfix item' })
map('n', ']q', ':cnext<CR>', { desc = 'Next Quickfix item' })
map('n', '[l', ':lprev<CR>', { desc = 'Previous Location item' })
map('n', ']l', ':lnext<CR>', { desc = 'Next Location item' })

-- Example: Save file with <leader>w
map('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
