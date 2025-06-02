-- init.lua

-- Set the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set 'termguicolors' before loading the color scheme
vim.opt.termguicolors = true

-- Auto install lazy.nvim if not found
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim
require("lazy").setup("mazen.plugins")

require("mazen.core.options")
require("mazen.core.keymaps")

-- Load other configurations (will be required by plugins in mazen.plugins.init anyway,
-- but explicitly requiring them here makes dependencies clearer sometimes, or you can
-- remove these lines and handle requirements within plugin configs)
-- For this setup, requiring within plugin configs is cleaner.
-- e.g., theme is loaded by its plugin spec, lsp by mason-lspconfig setup, etc.

-- Configure the theme (required here if not handled by a plugin spec config)
-- require("mazen.theme") -- This will be handled by the theme plugin config

-- Configure LSP, completion, treesitter, etc. (These will be required and setup
-- within the plugin configurations in mazen.plugins.init)

-- Example: require("mazen.lsp") -- Called by mason-lspconfig config
-- Example: require("mazen.cmp") -- Called by nvim-cmp config
-- Example: require("mazen.treesitter") -- Called by nvim-treesitter config
-- Example: require("mazen.nvimtree") -- Called by nvim-tree config
-- Example: require("mazen.telescope") -- Called by telescope config

-- Load the custom run_code function and keymap
require("mazen.run_code")

