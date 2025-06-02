-- lua/mazen/whichkey.lua

local M = {}

function M.setup()
  local wk = require('which-key')

  

  -- Register your keymaps
  -- The ' ' is your leader key
  wk.register({
      -- Example mappings (these assume you have these features set up)
      -- Remember to replace these with your actual keymaps!
      ['e'] = { ':NvimTreeToggle<CR>', 'File Explorer' }, -- Mapping for leader + e
      ['w'] = { ':w<CR>', 'Save' },                     -- Mapping for leader + w
      ['q'] = { ':q<CR>', 'Quit' },                     -- Mapping for leader + q

      -- LSP mappings (from mazen.lsp.init keymaps example)
      ['d'] = { name = '+Diagnostics',
          ['d'] = { vim.diagnostic.goto_next, 'Next Diagnostic' },
          ['p'] = { vim.diagnostic.goto_prev, 'Previous Diagnostic' },
          ['e'] = { vim.diagnostic.open_float, 'Show Line Diagnostics' },
          ['q'] = { vim.diagnostic.setloclist, 'Send to Loclist' },
      },
      ['r'] = { name = '+Run/Rename',
          ['n'] = { vim.lsp.buf.rename, 'Rename Symbol' },
          ['r'] = { require('mazen.run_code').RunCode, 'Run Code' }, -- Assuming you mapped RunCode to <leader>r
      },
      ['f'] = { name = '+Find/Format',
          ['f'] = { ':Telescope find_files<CR>', 'Find Files' },     -- Assuming Telescope find_files is <leader>ff
          ['g'] = { ':Telescope live_grep<CR>', 'Live Grep' },     -- Assuming Telescope live_grep is <leader>fg
          ['b'] = { ':Telescope buffers<CR>', 'List Buffers' },     -- Assuming Telescope buffers is <leader>fb
          ['h'] = { ':Telescope help_tags<CR>', 'Help Tags' },     -- Assuming Telescope help_tags is <leader>fh
          ['!'] = { function() vim.lsp.buf.format { async = true } end, 'Format Code' }, -- Assuming LSP format is <leader>f
      },
      ['h'] = { ':nohlsearch<CR>', 'Clear Search' }, -- Assuming <leader>n was changed to <leader>h for noh search
      ['a'] = { vim.lsp.buf.code_action, 'Code Action' }, -- Assuming <leader>ca was changed to <leader>a

      -- Example: Group for Window commands
      ['<C-w>'] = { name = '+Window', -- which-key uses <C-w> as a prefix natively for window commands
          ['h'] = { '<C-w>h', 'Window left' },
          ['j'] = { '<C-w>j', 'Window down' },
          ['k'] = { '<C-w>k', 'Window up' },
          ['l'] = { '<C-w>l', 'Window right' },
          -- Add other window commands if you use them
      },

  }, {
      -- Options for the registration command
      -- prefix = '<leader>' -- This is the default and can be omitted
  })

  -- You can register mappings for other modes too, e.g., Visual mode 'v'
  -- wk.register({
  --     ['<leader>'] = { name = '+Visual' },
  --     ['<leader>f'] = { ':'<C-u>Telescope vim_git_files<CR>', 'Find Files (Visual)' },
  -- }, { mode = 'v' })

end

return M
