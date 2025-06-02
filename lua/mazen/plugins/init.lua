-- lua/mazen/plugins/init.lua

return {
  -- The impatient plugin can speed up startup time (optional)
  -- { 'lewis6991/impatient.nvim' },

  -- Color Scheme: Everforest
    {
    'sainnhe/gruvbox-material',
    name = 'gruvbox-material',
    priority = 1000, -- Ensure it loads early if you want it as default
    config = function()
      vim.g.gruvbox_material_background = 'hard_light' -- Or 'medium_light', 'soft_light'
      -- vim.g.gruvbox_material_foreground = 'neutral' -- Optional: adjust foreground style
      vim.cmd.colorscheme("gruvbox-material")
      -- vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')
      -- Keep your transparency settings if desired, applied after colorscheme
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    end,
  },

    -- greeter
    {
        'goolord/alpha-nvim',
        config = function ()
            require'alpha'.setup(require'alpha.themes.dashboard'.config)
        end
    };
  -- File Explorer: nvim-tree.lua
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Optional, adds icons
    config = function()
      require('mazen.nvimtree').setup()
    end,
    keys = {
      { '<leader>e', ':NvimTreeToggle<CR>', desc = 'Toggle NvimTree' }
    }
  },

  -- Fuzzy Finder: telescope.nvim
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('mazen.telescope').setup()
    end,
    keys = {
      { '<leader>ff', ':Telescope find_files<CR>', desc = 'Find files' },
      { '<leader>fg', ':Telescope live_grep<CR>', desc = 'Live Grep' },
      { '<leader>fb', ':Telescope buffers<CR>', desc = 'Buffers' },
      { '<leader>fh', ':Telescope help_tags<CR>', desc = 'Help Tags' },
    }
  },
  -- Optional: FZF Native for Telescope (much faster)
  {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = vim.fn.executable('make') == 1, -- Build only if make is available
      enabled = vim.fn.executable('make') == 1,
      dependencies = { 'nvim-telescope/telescope.nvim' },
      config = function()
          require('telescope').load_extension('fzf')
      end
  },


  -- LSP Configuration: nvim-lspconfig
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason: installs LSP servers, DAP adapters, etc.
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim', -- Bridges Mason and nvim-lspconfig
    },
    config = function()
      require('mazen.lsp').setup()
    end,
  },

  -- Autocompletion: nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',     -- LSP source
      'hrsh7th/cmp-buffer',       -- Buffer source
      'hrsh7th/cmp-path',         -- Path source
      'saadparwaiz1/cmp_luasnip', -- Snippet source
      'L3MON4D3/Luasnip',         -- Snippet engine
    },
    config = function()
      require('mazen.cmp').setup()
    end,
  },
  
  -- Auto Pairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter", -- Load the plugin when entering insert mode
    config = function()
      require('nvim-autopairs').setup({}) -- Basic setup
      -- Optional: Enable integration with nvim-cmp if you want autopairs
      -- to play nicely with completion (recommended).
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp') -- Make sure cmp is required

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },

  -- Syntax Highlighting: nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Command to run after installation
    config = function()
      require('mazen.treesitter').setup()
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects', -- Optional, useful for text selection
    }
  },

  -- Optional: Add other useful plugins for CP (e.g., comment.nvim, indent-blankline)

  -- Commenting plugin
  {
    'numToStr/Comment.nvim',
    opts = {}, -- Use default options
    lazy = false, -- Load immediately
  },

  {
  "andweeb/presence.nvim",
  config = function()
    require("presence").setup({
      -- Optional config
      neovim_image_text = "The One True Text Editor",
      main_image = "neovim",
    })
  end,
  }, 

    -- Show key bindings popup: which-key.nvim
  {
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Load relatively late
    init = function()
      vim.o.timeout = true -- Required for which-key timeout
      vim.o.timeoutlen = 300 -- Time in ms for which-key to show (adjust as needed)
    end,
    config = function()
      require('mazen.whichkey').setup()
    end,
  },

  -- Indent guides (updated opts)
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'indent_blankline',
        opts = {
        indent = { enabled = true },
        scope = { enabled = true, show_exact_scope = true },
        hide_blankline = true,
        exclude = { filetypes = { 'help', 'terminal', 'lazy', 'mason', 'lspinfo', 'TelescopePrompt', 'Trouble', 'NvimTree', 'alpha', 'undotree' }, buftypes = { 'nofile', 'prompt', 'quickfix' } },
        treesitter = { enabled = true, use_treesitter_scope = true }
    },
        version = "v2.*",
    },

}
