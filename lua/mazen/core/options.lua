-- lua/mazen/core/options.lua

local opt = vim.opt

-- Editor UI
opt.number = true           -- Show line numbers
opt.relativenumber = true   -- Show relative line numbers
opt.cursorline = true       -- Highlight the current line
opt.signcolumn = 'yes'      -- Always show the sign column (for LSP diagnostics)
opt.linebreak = true        -- Wrap lines at word breaks
opt.showbreak = '↳ '        -- String to show when text is wrapped
opt.conceallevel = 0        -- 0: show concealeable text, 3: hide it completely
opt.smarttab = true

-- Indentation
opt.expandtab = true        -- Convert tabs to spaces
opt.tabstop = 4             -- Number of spaces a tab counts for
opt.shiftwidth = 4          -- Number of spaces to indent when shifting
opt.smartindent = true      -- Insert indents automatically

-- Searching
opt.hlsearch = true         -- Highlight search matches
opt.incsearch = true        -- Show search matches as you type
opt.ignorecase = true       -- Ignore case in search patterns
opt.smartcase = true        -- Override 'ignorecase' if the pattern contains uppercase letters

-- File Operations
opt.undodir = vim.fn.stdpath('data') .. '/undodir' -- Directory for undo files
opt.undofile = true         -- Enable persistent undo

-- Performance
opt.updatetime = 300        -- Decrease update time (for CursorHold events)
opt.timeoutlen = 500        -- Time to wait for a mapped sequence to complete (e.g., leader key)
opt.cmdheight = 0           -- Hide the command line unless needed
opt.laststatus = 3          -- Always show status line

-- Clipboard
opt.clipboard = 'unnamedplus' -- Use system clipboard

-- Split windows
opt.splitright = true       -- Split new windows to the right
opt.splitbelow = true       -- Split new windows below

-- Appearance
opt.mouse = 'a'             -- Enable mouse support in all modes
opt.pumheight = 10          -- Maximum number of entries in the popup menu
opt.isfname:append("@-@")   -- Allow spaces in filenames

-- Transparency (requires terminal emulator support)
-- Neovim doesn't control the background of the main window directly.
-- The 'winblend' option affects floating windows (like completion menus,
-- telescope finders), blending them with the background. A value of 10
-- means 10% transparency.
-- For the main window background transparency, configure your terminal emulator.
vim.opt.winblend = 10 -- Set winblend for floating windows
